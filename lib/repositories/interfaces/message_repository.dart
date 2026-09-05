// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:ripple/models/message.dart';

/// Abstraction over message storage and delivery.
///
/// Provides a reactive stream of messages for a given chat, paginated
/// access to history, and a method to send new messages. Implementations
/// follow an offline-first policy: cached data is returned instantly,
/// while any network synchronization happens behind the scenes.
abstract class MessageRepository {
  /// Returns the messages already available locally for [chatId], without
  /// waiting for a network round-trip.
  ///
  /// Returns an empty list if nothing is cached yet.
  List<Message> getCachedMessages(String chatId);

  /// Returns a reactive stream of messages for the given [chatId].
  ///
  /// The stream emits a new list whenever messages are added, edited,
  /// or removed. Messages are ordered chronologically.
  Stream<List<Message>> getMessages(String chatId);

  /// Loads up to [limit] messages older than [before].
  ///
  /// If [before] is `null`, loading starts from the oldest message
  /// currently known. Returns an empty list once there is no more
  /// history to load.
  ///
  /// Does not affect the stream returned by [getMessages] — callers are
  /// expected to merge the result into their own local message list.
  Future<List<Message>> loadOlderMessages(
    String chatId, {
    DateTime? before,
    int limit = 30,
  });

  /// Sends a new text message to [chatId] on behalf of [senderId].
  ///
  /// The message will appear in the stream returned by [getMessages]
  /// once it has been successfully delivered.
  Future<void> sendMessage(String chatId, String text, String senderId);

  /// Returns `true` if a previous [loadOlderMessages] call for [chatId]
  /// has already confirmed that there is no history older than what is
  /// currently cached.
  bool hasReachedHistoryStart(String chatId);

  /// Releases resources held by this repository.
  ///
  /// Called when the app shuts down or the repository is replaced.
  void dispose();
}
