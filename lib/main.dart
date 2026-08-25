import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/repositories/hive_settings_repository.dart';
import 'package:ripple/repositories/mock_message_repository.dart';
import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/providers/auth_provider.dart';
import 'package:ripple/models/app_settings.dart';
import 'package:ripple/utils/theme_mode.dart';
import 'package:ripple/generated/l10n.dart';
import 'package:ripple/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Path where hive can save data
  final appSupportDir = await getApplicationSupportDirectory();
  final messengerDir = Directory(p.join(appSupportDir.path, "ripple"));

  if (!await messengerDir.exists()) {
    await messengerDir.create(recursive: true);
  }

  /// Init hive
  Hive.init(messengerDir.path);
  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(AppThemeModeAdapter());

  final Box<AppSettings> settingsBox = await Hive.openBox<AppSettings>(
    "settings",
  );

  runApp(Messenger(settingsBox: settingsBox));
}

class Messenger extends StatelessWidget {
  final Box<AppSettings> settingsBox;

  const Messenger({super.key, required this.settingsBox});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(HiveSettingsRepository(settingsBox)),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..login("current_user"),
        ),
        Provider<MessageRepository>(
          create: (_) => MockMessageRepository(),
          dispose: (_, repository) => repository.dispose(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return MaterialApp(
            // --- APP TITLE ---
            onGenerateTitle: (context) => S.of(context).app_title,

            // --- LOCALIZATION ---
            locale: Locale(settingsProvider.languageCode),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // --- THEMES ---
            themeMode: settingsProvider.currentTheme.toFlutter(),

            // --- THEME LIGHT ---
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: settingsProvider.accentColor,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),

            // --- THEME DARK ---
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF1A1A1D),
              colorScheme: ColorScheme.fromSeed(
                seedColor: settingsProvider.accentColor,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),

            home: const Home(),
          );
        },
      ),
    );
  }
}
