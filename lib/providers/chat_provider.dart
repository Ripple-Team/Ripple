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

  List<Message> get messages => _messages;

  bool get isLoading => _isLoading;

  bool get isLoadingMore => _isLoadingMore;

  bool get hasMoreHistory => _hasMoreHistory;

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

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
