import 'package:hive/hive.dart';

import 'package:ripple/repositories/interfaces/session_repository.dart';

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