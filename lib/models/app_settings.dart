import 'package:hive/hive.dart';

part 'app_settings.g.dart';

/// Application settings model.
///
/// Stores user preferences like theme mode and etc.
@HiveType(typeId: 0)
class AppSettings {
  @HiveField(0)
  String theme;

  @HiveField(1)
  int accentColor;

  @HiveField(2)
  String languageCode;

  AppSettings({
    this.theme = "system",
    this.accentColor = 0xFF673AB7,
    this.languageCode = "en"
  });
}