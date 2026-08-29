import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ripple/models/chat.dart';
import 'package:ripple/repositories/interfaces/chat_repository.dart';

/// Provides the current user's list of chats to the UI.
///
/// Reads whatever is cached at construction time for an instant first
/// render, then keeps [chats] in sync with [ChatRepository.getChats]
class ChatListProvider extends ChangeNotifier {
  StreamSubscription<List<Chat>>? _subscription;
  final ChatRepository _repository;

  late List<Chat> _chats;

  List<Chat> get chats => _chats;

  ChatListProvider(this._repository) {
    _chats = _repository.getCachedChats();
    _subscription = _repository.getChats().listen((chats) {
      _chats = chats;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
