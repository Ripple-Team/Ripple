import 'package:ripple/repositories/interfaces/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  // TODO: real users
  final Map<String, String> _users = {};

  @override
  Future<String> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final username_ = username.trim();

    if (username_.isEmpty || password.isEmpty) {
      throw AuthException('empty_credentials');
    }
    if (_users[username_] != password) {
      throw AuthException('invalid_credentials');
    }

    return username_;
  }

  @override
  Future<String> register(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final username_ = username.trim();

    if (username_.isEmpty || password.isEmpty) {
      throw AuthException('empty_credentials');
    }
    if (_users.containsKey(username_)) {
      throw AuthException('username_taken');
    }
    _users[username_] = password;
    return username_;
  }
}