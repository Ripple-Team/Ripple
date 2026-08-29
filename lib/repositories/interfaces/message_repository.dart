import 'package:ripple/models/message.dart';

/// Abstraction over message storage and delivery.
///
/// Provides a reactive stream of messages for a given chat,
/// and methods to send new messages.
abstract class MessageRepository {
  ///Returns whatever messages are already available in memory for [chatId],
  ///without waiting for a network round-trip. Empty list if nothing cached yet.
  List<Message> getCachedMessages(String chatId);

  /// Returns a stream of messages for the given [chatId].
  ///
  /// The stream emits a new list whenever messages are added,
  /// edited, or removed. Messages are ordered chronologically.
  Stream<List<Message>> getMessages(String chatId);

  /// Sends a new text message to the given [chatId] on behalf of [senderId].
  ///
  /// The message will appear in the stream returned by [getMessages]
  /// once successfully delivered.
  Future<void> sendMessage(String chatId, String text, String senderId);

  /// Releases resources held by this repository.
  ///
  /// Called when the app shuts down or the repository is replaced.
  void dispose();
}
