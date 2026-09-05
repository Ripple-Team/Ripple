// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:hive_ce/hive_ce.dart';

import 'package:ripple/repositories/interfaces/session_repository.dart';

/// Hive-backed implementation of [SessionRepository].
///
/// Stores the user ID as a single string entry under the key [_userIdKey].
class HiveSessionRepository implements SessionRepository {
  static const _userIdKey = 'user_id';
  final Box<String> _box;

  HiveSessionRepository(this._box);

  @override
  String? getSavedUserID() => _box.get(_userIdKey);

  @override
  Future<void> saveUserId(String userId) => _box.put(_userIdKey, userId);

  @override
  Future<void> clearUserId() => _box.delete(_userIdKey);
}