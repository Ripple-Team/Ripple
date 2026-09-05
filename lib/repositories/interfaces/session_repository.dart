// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
/// Abstraction for persisting the authenticated user's session.
///
/// Implementations must survive app restarts and be safe to call
/// from the UI thread. Used by [AuthProvider] to maintain login state.
abstract class SessionRepository {
  /// Returns the previously saved user ID, or `null` if no session exists.
  ///
  /// This operation is synchronous because most local storage backends
  /// (e.g. Hive, SharedPreferences) support sync reads.
  String? getSavedUserID();

  /// Persists the given [userId] as the active session.
  ///
  /// Replaces any previously saved user ID.
  Future<void> saveUserId(String userId);

  /// Removes the stored session, effectively logging the user out.
  ///
  /// Safe to call even if no session was previously saved.
  Future<void> clearUserId();
}