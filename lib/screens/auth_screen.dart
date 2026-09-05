// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/providers/auth_provider.dart';
import 'package:ripple/generated/l10n.dart';

enum _AuthMode { login, register }

/// Combined login and registration screen.
///
/// Toggles between login and registration modes via a text button.
/// Displays validation errors from [AuthProvider] and local checks
/// (e.g. password confirmation mismatch).
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  _AuthMode _mode = _AuthMode.login;

  String? _localErrorCode;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _mode = _mode == _AuthMode.login ? _AuthMode.register : _AuthMode.login;
      _localErrorCode = null;
      _confirmPasswordController.clear();
    });
  }

  void _submit() {
    final auth = context.read<AuthProvider>();

    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (_mode == _AuthMode.register && password != confirmPassword) {
      setState(() => _localErrorCode = 'passwords_dont_match');
      return;
    }
    setState(() => _localErrorCode = null);

    if (_mode == _AuthMode.login) {
      auth.login(username, password);
    } else {
      auth.register(username, password);
    }
  }

  String? _errorText(S s, String? errorCode) {
    return switch (errorCode) {
      null => null,
      'empty_credentials' => s.auth_screen_error_empty_credentials,
      'invalid_credentials' => s.auth_screen_error_invalid_credentials,
      'username_taken' => s.auth_screen_error_username_taken,
      'passwords_dont_match' => s.auth_screen_passwords_dont_match,
      _ => s.auth_screen_error_unknown,
    };
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final auth = context.watch<AuthProvider>();
    final isRegister = _mode == _AuthMode.register;
    final errorText = _errorText(s, _localErrorCode ?? auth.errorCode);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isRegister ? s.auth_screen_register_title : s.auth_screen_title,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 24),

              /// Login
              TextField(
                controller: _usernameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: s.auth_screen_username_label,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              /// Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                textInputAction: isRegister
                    ? TextInputAction.next
                    : TextInputAction.done,
                onSubmitted: isRegister ? null : (_) => _submit(),
                decoration: InputDecoration(
                  labelText: s.auth_screen_password_label,
                  border: const OutlineInputBorder(),
                ),
              ),

              if (isRegister) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: s.auth_screen_confirm_password_label,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],

              if (errorText != null) ...[
                const SizedBox(height: 8),
                Text(
                  errorText,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ],

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: auth.isLoading ? null : _submit,
                  child: auth.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          isRegister
                              ? s.auth_screen_register_button
                              : s.auth_screen_submit_button,
                        ),
                ),
              ),

              TextButton(
                onPressed: auth.isLoading ? null : _toggleMode,
                child: Text(
                  isRegister
                      ? s.auth_screen_toggle_to_login
                      : s.auth_screen_toggle_to_register,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
