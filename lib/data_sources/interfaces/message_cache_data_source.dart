// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:ripple/models/message.dart';

/// Local persistent cache of messages, keyed by chat id.
///
/// A low-level data source: it knows only about local storage and exposes
/// raw read/write operations. Used by [MessageRepository] implementations
/// to provide offline-first reads — cached data can be shown instantly on
/// cold start, before any network round-trip completes.
///
/// Implementations must not contain business logic such as merging,
/// deduplication, or ordering policies — those belong to repositories.
abstract class MessageCacheDataSource {
  /// Returns the cached messages for [chatId], or an empty list if
  /// nothing is cached yet.
  List<Message> getMessages(String chatId);

  /// Overwrites the cached messages for [chatId] with [messages].
  Future<void> saveMessages(String chatId, List<Message> messages);
}
