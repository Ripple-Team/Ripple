import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _currentUserId;
  String? get currentUserId => _currentUserId;

  bool isLoggedIn() => _currentUserId != null;

  void login(String userId) {
    _currentUserId = userId;
    notifyListeners();
  }

  void logout() {
    _currentUserId = null;
    notifyListeners();
  }
}