import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ripple/models/message.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';

class ChatProvider extends ChangeNotifier {
  StreamSubscription<List<Message>>? _subscription;
  final MessageRepository _repository;
  final String _chatId;

  List<Message> _messages = [];
  bool _isLoading = true;

  // --- GETTERS ---
  List<Message> get messages => _messages;

  bool get isLoading => _isLoading;

  ChatProvider(this._repository, this._chatId) {
    _listenToMessages();
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

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final tempMsg = Message(
      id: "temp_${DateTime.now().millisecondsSinceEpoch}",
      text: text,
      senderId: "current_user",
      time: DateTime.now(),
    );
    _messages = [..._messages, tempMsg];
    notifyListeners();

    try {
      await _repository.sendMessage(_chatId, text);
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
