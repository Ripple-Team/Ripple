import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/models/message.dart';

/// In-memory mock of [MessageRepository] for development and testing.
///
/// Emits a pre-populated list of mock messages on [getMessages] subscription
/// with a short simulated network delay.
@visibleForTesting
class MockMessageRepository implements MessageRepository {
  final _controller = StreamController<List<Message>>.broadcast();

  final List<Message> _mockMessages = [
    Message(
      id: "1",
      text: "Приветик, как дела? :3",
      senderId: "19234",
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    Message(
      id: "2",
      text: "Нормально, а у тебя как? :3",
      senderId: "gg",
      time: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    Message(
      id: "3",
      text: "Хорошо, го гулять? :3",
      senderId: "19234",
      time: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    Message(
      id: "4",
      text: "А то одному скучно",
      senderId: "19234",
      time: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
  ];

  @override
  Stream<List<Message>> getMessages(String chatId) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!_controller.isClosed) {
        _controller.add(List.unmodifiable(_mockMessages));
      }
    });
    return _controller.stream;
  }

  @override
  Future<void> sendMessage(String chatId, String text, String senderId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final newMsg = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text,
      senderId: senderId,
      time: DateTime.now(),
    );

    _mockMessages.add(newMsg);
    if (!_controller.isClosed) {
      _controller.add(List.unmodifiable(_mockMessages));
    }
  }

  @override
  void dispose() => _controller.close();
}