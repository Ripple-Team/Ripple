// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:hive_ce/hive_ce.dart';

import 'package:ripple/data_sources/interfaces/message_cache_data_source.dart';
import 'package:ripple/models/message.dart';

/// Hive-backed implementation of [MessageCache].
///
/// Stores messages as one 'List&lt;Message&gt;' per chat, keyed by chat id,
/// in the given Hive [_box]
class HiveMessageCacheDataSource implements MessageCacheDataSource {
  final Box _box;

  HiveMessageCacheDataSource(this._box);

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