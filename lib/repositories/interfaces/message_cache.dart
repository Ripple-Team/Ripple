import 'package:ripple/models/message.dart';

/// Local persistent cache of messages, keyed by chat.
///
/// Used internally by [MessageRepository] implementations for
/// offline-first reads - cached data can be shown instantly on cold
/// start, before any network round-trip completes
abstract class MessageCache {
  /// Returns cached messages for [chatId], or an empty list if nothing is cached
  List<Message> getMessages(String chatId);

  /// Overwrites the cached messages for [chatId]
  Future<void> saveMessages(String chatId, List<Message> messages);
}
