abstract class SessionRepository {
  String? getSavedUserID();
  Future<void> saveUserId(String userId);
  Future<void> clearUserId();
}