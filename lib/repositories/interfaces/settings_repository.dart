import 'package:ripple/models/app_settings.dart';

/// Abstraction over persistent application settings.
abstract class SettingsRepository {
  /// Returns the current settings, or a default instance if none are saved.
  AppSettings getSettings();

  /// Persists the given [settings] to storage.
  Future<void> saveSettings(AppSettings settings);
}