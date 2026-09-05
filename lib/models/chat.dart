// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:hive_ce/hive_ce.dart';

part 'chat.g.dart';

/// A conversation between the current user and a single contact.
///
/// Currently models 1-on-1 chats only; group chats are not yet supported
@HiveType(typeId: 5)
class Chat {
  @HiveField(0)
  final String id;

  /// The id of the [Contact] this chat is with
  @HiveField(1)
  final String contactId;

  Chat({required this.id, required this.contactId});
}
