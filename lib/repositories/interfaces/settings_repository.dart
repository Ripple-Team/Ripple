import 'package:ripple/models/app_settings.dart';

abstract class SettingsRepository {
  AppSettings getSettings();
  Future<void> saveSettings(AppSettings settings);
}