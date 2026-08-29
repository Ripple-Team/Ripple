import 'package:hive/hive.dart';

import 'package:ripple/repositories/interfaces/message_cache.dart';
import 'package:ripple/models/message.dart';

class HiveMessageCache implements MessageCache {
  final Box _box;

  HiveMessageCache(this._box);

  @override
  List<Message> getMessages(String chatId) {
    final raw = _box.get(chatId);
    if (raw == null) return const [];
    return List.unmodifiable((raw as List).cast<Message>());
  }

  @override
  Future<void> saveMessages(String chatId, List<Message> messages) =>
      _box.put(chatId, messages);
}