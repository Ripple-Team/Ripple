import 'package:hive/hive.dart';

import 'package:ripple/utils/theme_mode.dart';

part 'app_settings.g.dart';

/// Application settings model.
///
/// Stores user preferences like theme mode and etc.
@HiveType(typeId: 0)
class AppSettings {
  @HiveField(0)
  final AppThemeMode theme;

  @HiveField(1)
  final int accentColor;

  @HiveField(2)
  final String languageCode;

  AppSettings({
    this.theme = AppThemeMode.system,
    this.accentColor = 0xFF673AB7,
    this.languageCode = "en",
  });

  AppSettings copyWith({
    AppThemeMode? theme,
    int? accentColor,
    String? languageCode,
  }) {
    return AppSettings(
      theme: theme ?? this.theme,
      accentColor: accentColor ?? this.accentColor,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
