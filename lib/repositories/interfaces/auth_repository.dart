/// Exception thrown by [AuthRepository] when authentication fails.
///
/// The [message] contains a localization key (e.g. `"invalid_credentials"`)
/// that UI can translate via [S].
class AuthException implements Exception {
  /// Localization key describing the error cause.
  final String message;

  AuthException(this.message);
}

/// Abstraction over authentication operations.
///
/// Implementations must be safe to call from the UI thread and
/// should throw [AuthException] on authentication failures.
abstract class AuthRepository {
  /// Authenticates the user with the given credentials.
  ///
  /// Returns the user ID on success.
  /// Throws [AuthException] with code:
  /// * `"empty_credentials"` if [username] or [password] is empty.
  /// * `"invalid_credentials"` if the credentials are incorrect.
  Future<String> login(String username, String password);

  /// Creates a new user account with the given credentials.
  ///
  /// Returns the new user ID on success.
  /// Throws [AuthException] with code:
  /// * `"empty_credentials"` if [username] or [password] is empty.
  /// * `"username_taken"` if the username is already registered.
  Future<String> register(String username, String password);
}
