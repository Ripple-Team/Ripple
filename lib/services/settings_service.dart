import 'package:hive/hive.dart';

import 'package:messenger/models/app_settings.dart';

class SettingsService {
  static const _boxName = "settings";
  static const _settingsKey = "app_settings";

  late Box<AppSettings> _box;

  /// Opens the settings box
  Future<void> init() async {
    _box = await Hive.openBox<AppSettings>(_boxName);
  }

  /// Returns current settings or defaults if not found
  AppSettings getSettings() {
    return _box.get(_settingsKey) ?? AppSettings();
  }

  /// Save the updated settings to Hive
  Future<void> saveSettings(AppSettings settings) async {
    await _box.put(_settingsKey, settings);
  }
}
