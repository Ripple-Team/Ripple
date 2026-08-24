import 'package:flutter/material.dart';

import 'package:messenger/repositories/interfaces/settings_repository.dart';
import 'package:messenger/models/app_settings.dart';
import 'package:messenger/utils/theme_mode.dart';
import 'package:messenger/generated/l10n.dart';

/// State manager for application settings.
class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this._repository) {
    _settings = _repository.getSettings();
  }

  final SettingsRepository _repository;
  AppSettings _settings = AppSettings();

  // --- GETTERS ---
  AppSettings get settings => _settings;
  String get languageCode => _settings.languageCode;
  Color get accentColor => Color(_settings.accentColor);
  AppThemeMode get currentTheme => _settings.theme;

  // --- SETTERS ---
  Future<void> setTheme(AppThemeMode theme) async {
    _settings = _settings.copyWith(theme: theme);
    await _repository.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> setAccentColor(Color color) async {
    _settings = _settings.copyWith(accentColor: color.toARGB32());
    await _repository.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _settings = _settings.copyWith(languageCode: code);
    await _repository.saveSettings(_settings);
    await S.load(Locale(code));
    notifyListeners();
  }
}