import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ripple/repositories/interfaces/message_cache.dart';

import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/models/message.dart';

/// In-memory mock of [MessageRepository] for development and testing.
///
/// Emits a pre-populated list of mock messages on [getMessages] subscription
/// with a short simulated network delay.
@visibleForTesting
class MockMessageRepository implements MessageRepository {
  final MessageCache _cache;

  final Map<String, List<Message>> _messagesByChat = {};
  final Map<String, StreamController<List<Message>>> _controllers = {};

  MockMessageRepository(this._cache);

  List<Message> _messagesFor(String chatId) {
    return _messagesByChat.putIfAbsent(
      chatId,
      () => _cache.getMessages(chatId),
    );
  }

  StreamController<List<Message>> _controllerFor(String chatId) {
    return _controllers.putIfAbsent(
      chatId,
      () => StreamController<List<Message>>.broadcast(),
    );
  }

  @override
  List<Message> getCachedMessages(String chatId) =>
      List.unmodifiable(_messagesFor(chatId));

  @override
  Stream<List<Message>> getMessages(String chatId) {
    final controller = _controllerFor(chatId);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!controller.isClosed) {
        controller.add(List.unmodifiable(_messagesFor(chatId)) );
      }
    });
    return controller.stream;
  }

  @override
  Future<void> sendMessage(String chatId, String text, String senderId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final updated = [
      ..._messagesFor(chatId),
      Message(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        chatId: chatId,
        text: text,
        senderId: senderId,
        time: DateTime.now(),
      ),
    ];

    _messagesByChat[chatId] = updated;
    await _cache.saveMessages(chatId, updated);

    final controller = _controllerFor(chatId);
    if (!controller.isClosed) {
      controller.add(List.unmodifiable(updated));
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.close();
    }
  }
}
