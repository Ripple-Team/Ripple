import 'package:flutter/material.dart';

import 'package:ripple/repositories/interfaces/session_repository.dart';
import 'package:ripple/repositories/interfaces/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final SessionRepository _sessionRepository;

  String? _currentUserId;
  String? get currentUserId => _currentUserId;
  bool get isLoggedIn => _currentUserId != null;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorCode;
  String? get errorCode => _errorCode;

  AuthProvider(this._authRepository, this._sessionRepository) {
    _currentUserId = _sessionRepository.getSavedUserID();
  }

  Future<void> login(String username, String password) =>
      _authenticate(() => _authRepository.login(username, password));

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

  Future<void> logout() async {
    _currentUserId = null;
    await _sessionRepository.clearUserId();
    notifyListeners();
  }
}
