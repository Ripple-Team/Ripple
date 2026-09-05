// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ripple/models/message.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';

/// Manages the state of a single chat conversation.
///
/// Subscribes to a stream of messages from [MessageRepository]
/// and provides methods to send new messages with optimistic UI updates.
class ChatProvider extends ChangeNotifier {
  StreamSubscription<List<Message>>? _subscription;
  final MessageRepository _repository;
  final String _chatId;
  final String _currentUserId;

  List<Message> _messages = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMoreHistory = false;
  Message? _editingMessage;

  List<Message> get messages => _messages;

  bool get isLoading => _isLoading;

  bool get isLoadingMore => _isLoadingMore;

  bool get hasMoreHistory => _hasMoreHistory;

  Message? get editingMessage => _editingMessage;

  ChatProvider(this._repository, this._chatId, this._currentUserId) {
    _hasMoreHistory = !_repository.hasReachedHistoryStart(_chatId);
    _messages = _repository.getCachedMessages(_chatId);
    _isLoading = _messages.isEmpty;
    _listenToMessages();

    if (messages.isEmpty) {
      loadOlderMessages();
    }
  }

  void _listenToMessages() {
    _subscription = _repository
        .getMessages(_chatId)
        .listen(
          (messages) {
            _messages = messages;
            _isLoading = false;
            notifyListeners();
          },
          onError: (error) {
            _isLoading = false;
            // TODO: error message
            notifyListeners();
          },
        );
  }

  Future<void> loadOlderMessages() async {
    if (_isLoadingMore || !_hasMoreHistory) return;

    _isLoadingMore = true;
    notifyListeners();

    final older = await _repository.loadOlderMessages(
      _chatId,
      before: _messages.isEmpty ? null : _messages.first.time,
    );
    if (older.isEmpty) {
      _hasMoreHistory = false;
    } else {
      _messages = [...older, ..._messages];
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  /// Sends a new message with an optimistic UI update.
  ///
  /// A temporary message is immediately added to [messages]. If the
  /// repository call fails, the temporary message is removed.
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final tempMsg = Message(
      id: "temp_${DateTime.now().millisecondsSinceEpoch}",
      chatId: _chatId,
      text: text,
      senderId: _currentUserId,
      time: DateTime.now(),
    );
    _messages = [..._messages, tempMsg];
    notifyListeners();

    try {
      await _repository.sendMessage(_chatId, text, _currentUserId);
    } catch (e) {
      _messages = _messages.where((msg) => msg.id != tempMsg.id).toList();
      notifyListeners();
    }
  }

  void startEditing(Message message) {
    _editingMessage = message;
    notifyListeners();
  }

  void cancelEditing() {
    _editingMessage = null;
    notifyListeners();
  }

  Future<void> editMessage(String messageId, String newText) async {
    final text = newText.trim();
    if (text.isEmpty) return;

    final original = _messages.firstWhere((m) => m.id == messageId);

    _messages = _messages
        .map(
          (m) => m.id == messageId
              ? m.copyWith(text: text, editedAt: DateTime.now())
              : m,
        )
        .toList();
    _editingMessage = null;
    notifyListeners();

    try {
      await _repository.editMessage(_chatId, messageId, newText);
    } catch (e) {
      _messages = _messages.map((m) => m.id == messageId ? original : m).toList();
      notifyListeners();
      // TODO: error message
    }
  }

  Future<void> deleteMessage(String messageId) async {
    final original = _messages.firstWhere((m) => m.id == messageId);

    _messages = _messages.where((m) => m.id != messageId).toList();
    notifyListeners();

    try {
      await _repository.deleteMessage(_chatId, messageId);
    } catch (e) {
      _messages = [..._messages, original]..sort((a, b) => a.time.compareTo(b.time));
      notifyListeners();
      // TODO: error message
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
