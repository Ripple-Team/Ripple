// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

import 'package:ripple/repositories/interfaces/settings_repository.dart';
import 'package:ripple/models/app_settings.dart';
import 'package:ripple/utils/theme_mode.dart';
import 'package:ripple/generated/l10n.dart';

/// State manager for user-configurable application settings.
///
/// Changes are persisted to the underlying [SettingsRepository]
/// and propagated to the UI via [ChangeNotifier].
class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _repository;
  AppSettings _settings = AppSettings();

  /// The raw settings object. Prefer specific getters below when possible.
  AppSettings get settings => _settings;

  /// The currently selected language code (e.g. `"en"`, `"ru"`).
  String get languageCode => _settings.languageCode;

  /// The currently selected accent color.
  Color get accentColor => Color(_settings.accentColor);

  /// The currently selected theme mode.
  AppThemeMode get currentTheme => _settings.theme;

  /// Creates a [SettingsProvider] and loads the initial settings from [repository].
  SettingsProvider(this._repository) {
    _settings = _repository.getSettings();
  }

  /// Updates the theme mode and persists the change.
  Future<void> setTheme(AppThemeMode theme) async {
    _settings = _settings.copyWith(theme: theme);
    await _repository.saveSettings(_settings);
    notifyListeners();
  }

  /// Updates the accent color and persists the change.
  Future<void> setAccentColor(Color color) async {
    _settings = _settings.copyWith(accentColor: color.toARGB32());
    await _repository.saveSettings(_settings);
    notifyListeners();
  }

  /// Updates the language and reloads localization resources.
  ///
  /// Calls [S.load] to refresh translated strings before notifying listeners.
  Future<void> setLanguage(String code) async {
    _settings = _settings.copyWith(languageCode: code);
    await _repository.saveSettings(_settings);
    await S.load(Locale(code));
    notifyListeners();
  }
}