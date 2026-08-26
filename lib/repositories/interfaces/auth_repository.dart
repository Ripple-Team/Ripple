class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

abstract class AuthRepository {
  Future<String> login(String username, String password);
  Future<String> register(String username, String password);
}