// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

import 'package:ripple/repositories/interfaces/session_repository.dart';
import 'package:ripple/repositories/interfaces/auth_repository.dart';

/// Manages authentication state for the current user.
///
/// Handles login, registration, and session persistence.
/// UI should listen to this provider to show loading indicators
/// and react to authentication changes.
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final SessionRepository _sessionRepository;

  String? _currentUserId;
  bool _isLoading = false;
  String? _errorCode;

  /// The ID of the currently authenticated user, or `null` if logged out.
  String? get currentUserId => _currentUserId;

  /// Whether a user is currently authenticated.
  bool get isLoggedIn => _currentUserId != null;

  /// Whether an authentication operation is in progress.
  bool get isLoading => _isLoading;

  /// Error code from the last failed authentication attempt, or `null`.
  String? get errorCode => _errorCode;

  /// Creates an [AuthProvider] and restores the previous session if available.
  AuthProvider(this._authRepository, this._sessionRepository) {
    _currentUserId = _sessionRepository.getSavedUserID();
  }

  /// Attempts to log in with the given credentials.
  ///
  /// On success, persists the user ID via [SessionRepository].
  /// On failure, sets [errorCode] to the error message.
  Future<void> login(String username, String password) =>
      _authenticate(() => _authRepository.login(username, password));

  /// Attempts to register a new account with the given credentials.
  ///
  /// Behavior mirrors [login] on success and failure.
  Future<void> register(String username, String password) =>
    _authenticate(() => _authRepository.register(username, password));

  Future<void> _authenticate(Future<String> Function() action) async {
    _isLoading = true;
    _errorCode = null;
    notifyListeners();

    try {
      final userId = await action();
      _currentUserId = userId;
      await _sessionRepository.saveUserId(userId);
    } on AuthException catch (e) {
      _errorCode = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clears the current session and logs the user out.
  Future<void> logout() async {
    _currentUserId = null;
    await _sessionRepository.clearUserId();
    notifyListeners();
  }
}
