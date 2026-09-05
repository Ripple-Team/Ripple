// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:ripple/models/message.dart';

/// Contract for fetching and delivering messages from the backend.
///
/// The remote data source of the message domain: it represents the
/// "server side" of message exchange. Implementations may use HTTP,
/// WebSockets, or any other transport — callers do not care which.
///
/// During development this interface is implemented by an in-memory mock;
/// once the backend exists, a real transport-backed implementation takes
/// its place without affecting repositories or anything above them.
abstract class RemoteMessageDataSource {
  /// Fetches a page of up to [limit] messages older than [before].
  ///
  /// If [before] is `null`, the page ends at the oldest message the
  /// backend knows about. Messages are ordered chronologically.
  ///
  /// Returns an empty list once there is no more history to load.
  Future<List<Message>> fetchOlder(
    String chatId, {
    DateTime? before,
    int limit = 30,
  });

  /// Sends a new text message to [chatId] on behalf of [senderId].
  ///
  /// Completes once the backend has accepted the message. Persisting
  /// the message locally is the caller's responsibility.
  Future<void> send(String chatId, String text, String senderId);

  /// Emits messages delivered to [chatId] in real time.
  ///
  /// Backed by a push channel (e.g. a WebSocket) in real implementations.
  /// Repositories are expected to merge these events into the chat
  /// stream and the local cache.
  Stream<Message> incoming(String chatId);

  /// Returns `true` once [fetchOlder] has confirmed that the backend
  /// holds no history older than what has already been fetched.
  bool hasReachedHistoryStart(String chatId);
}
