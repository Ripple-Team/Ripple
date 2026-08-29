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

  /// Loads messages older then [before] (or the oldest known message, if
  /// [before] if null), up to [limit] at a time
  ///
  /// Returns an empty list once there is no more history to load.
  /// Does not affect the stream returned by [getMessages] - callers are
  /// expected to merge the result into their own local message list
  Future<List<Message>> loadOlderMessages(
    String chatId, {
    DateTime? before,
    int limit = 30,
  });

  /// Sends a new text message to the given [chatId] on behalf of [senderId].
  ///
  /// The message will appear in the stream returned by [getMessages]
  /// once successfully delivered.
  Future<void> sendMessage(String chatId, String text, String senderId);

  /// Returns true if a previous [loadOlderMessages] call for [chatId]
  /// already confirmed there is no more history before what's cached
  bool hasReachedHistoryStart(String chatId);

  /// Releases resources held by this repository.
  ///
  /// Called when the app shuts down or the repository is replaced.
  void dispose();
}
