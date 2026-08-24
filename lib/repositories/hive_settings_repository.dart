import 'package:hive/hive.dart';

import 'package:messenger/repositories/interfaces/settings_repository.dart';
import 'package:messenger/models/app_settings.dart';

class HiveSettingsRepository implements SettingsRepository {
  static const _settingsKey = 'app_settings';
  final Box<AppSettings> _box;

  HiveSettingsRepository(this._box);

  @override
  AppSettings getSettings() {
    return _box.get(_settingsKey) ?? AppSettings();
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _box.put(_settingsKey, settings);
  }
}