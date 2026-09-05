// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:hive_ce/hive_ce.dart';

part 'contact.g.dart';

/// A person the current user can chat with
@HiveType(typeId: 4)
class Contact {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime? lastSeen;

  Contact({required this.id, required this.name, required this.lastSeen});
}
