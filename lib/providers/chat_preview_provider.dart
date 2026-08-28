import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/models/message.dart';

/// Provides the most recent message of chat, for preview/list tiles.
///
/// Lighter-weight than [ChatProvider]: subscribes to the same message
/// stream, but only exposes the last message rather than the full history
class ChatPreviewProvider extends ChangeNotifier {
  StreamSubscription<List<Message>>? _subscription;

  Message? _lastMessage;

  Message? get lastMessage => _lastMessage;

  ChatPreviewProvider(MessageRepository repository, String chatId) {
    _subscription = repository.getMessages(chatId).listen((messages) {
      _lastMessage = messages.isEmpty ? null : messages.last;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
