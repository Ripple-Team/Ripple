// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ripple/repositories/interfaces/chat_repository.dart';
import 'package:ripple/models/chat.dart';

/// In-memory mock of [ChatRepository] for development and testing.
///
/// Emits a fixed, pre-populated list of chats on [getChats] subscription
/// with a short simulated network delay
@visibleForTesting
class MockChatRepository implements ChatRepository {
  final _controller = StreamController<List<Chat>>.broadcast();

  final List<Chat> _chats = [
    Chat(id: "1", contactId: "1"),
    Chat(id: "2", contactId: "2")
  ];

  @override
  List<Chat> getCachedChats() => List.unmodifiable(_chats);

  @override
  Stream<List<Chat>> getChats() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!_controller.isClosed) _controller.add(List.unmodifiable(_chats));
    });
    return _controller.stream;
  }

  @override
  void dispose() => _controller.close();
}