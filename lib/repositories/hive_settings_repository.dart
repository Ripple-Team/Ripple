import 'package:hive/hive.dart';

import 'package:ripple/repositories/interfaces/settings_repository.dart';
import 'package:ripple/models/app_settings.dart';

/// Hive-backed implementation of [SettingsRepository].
///
/// Stores the entire [AppSettings] object under a single key.
class HiveSettingsRepository implements SettingsRepository {
  static const _settingsKey = 'app_settings';
  final Box<AppSettings> _box;

  HiveSettingsRepository(this._box);

  @override
  AppSettings getSettings() => _box.get(_settingsKey) ?? AppSettings();

  @override
  Future<void> saveSettings(AppSettings settings) =>
      _box.put(_settingsKey, settings);
}