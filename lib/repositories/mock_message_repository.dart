// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ripple/data_sources/interfaces/message_cache_data_source.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/models/message.dart';

/// In-memory mock of [MessageRepository] for development and testing.
///
/// Emits a pre-populated list of mock messages on [getMessages] subscription
/// with a short simulated network delay.
@visibleForTesting
class MockMessageRepository implements MessageRepository {
  final MessageCacheDataSource _cache;

  final Map<String, List<Message>> _messagesByChat = {};
  final Map<String, StreamController<List<Message>>> _controllers = {};
  final Set<String> _exhaustedChats = {};

  /// Synthetic "server-side" history per chat, used only to test
  /// [loadOlderMessages] - a real backend would provide this instead
  final Map<String, List<Message>> _fullHistory = {};

  MockMessageRepository(this._cache);

  List<Message> _messagesFor(String chatId) {
    return _messagesByChat.putIfAbsent(
      chatId,
          () => _cache.getMessages(chatId),
    );
  }

  List<Message> _fullHistoryFor(String chatId) {
    return _fullHistory.putIfAbsent(chatId, () {
      final now = DateTime.now();

      return List.generate(40, (i) {
        final index = 39 - i;
        return Message(
          id: "seed_${chatId}_$index",
          chatId: chatId,
          text: "Historic message №$index",
          senderId: "contact_$chatId",
          // not real contact,
          time: now.subtract(Duration(hours: (index + 1) * 3)),
        );
      });
    });
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
        controller.add(List.unmodifiable(_messagesFor(chatId)));
      }
    });
    return controller.stream;
  }

  @override
  Future<List<Message>> loadOlderMessages(String chatId, {
    DateTime? before,
    int limit = 30,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final cutoff = before ?? DateTime.now();
    final history =
    _fullHistoryFor(chatId).where((m) => m.time.isBefore(cutoff)).toList()
      ..sort((a, b) => b.time.compareTo(a.time));

    final page = history
        .take(limit)
        .toList()
        .reversed
        .toList();
    if (page.isEmpty) {
      _exhaustedChats.add(chatId);
      return const [];
    }

    final merged = [...page, ..._messagesFor(chatId)]
      ..sort((a, b) => a.time.compareTo(b.time));

    _messagesByChat[chatId] = merged;
    await _cache.saveMessages(chatId, merged);

    return page;
  }

  @override
  Future<void> sendMessage(String chatId, String text, String senderId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final updated = [
      ..._messagesFor(chatId),
      Message(
        id: DateTime
            .now()
            .microsecondsSinceEpoch
            .toString(),
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
  bool hasReachedHistoryStart(String chatId)  => _exhaustedChats.contains(chatId);

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.close();
    }
  }
}
