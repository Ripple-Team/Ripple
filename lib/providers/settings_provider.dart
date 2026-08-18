import 'package:flutter/material.dart';

import 'package:messenger/services/settings_service.dart';
import 'package:messenger/models/app_settings.dart';
import 'package:messenger/generated/l10n.dart';

/// State manager for application settings.
class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this._service);

  final SettingsService _service;
  AppSettings _settings = AppSettings();

  AppSettings get settings => _settings;

  String get languageCode => _settings.languageCode;
  Color get accentColor => Color(_settings.accentColor);
  ThemeMode get currentTheme {
    final theme = _settings.theme;
    switch (theme) {
      case "system":
        return ThemeMode.system;
      case "light":
        return ThemeMode.light;
      default:
        return ThemeMode.dark;
    }
  }

  /// Loads settings from Hive. Called at app startup
  Future<void> loadSettings() async {
    await _service.init();
    _settings = _service.getSettings();
    notifyListeners();
  }

  Future<void> setTheme(String theme) async {
    _settings.theme = theme;
    await _service.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> setAccentColor(Color color) async {
    _settings.accentColor = color.toARGB32();
    await _service.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _settings.languageCode = code;
    await _service.saveSettings(_settings);
    await S.load(Locale(code));
    notifyListeners();
  }
}