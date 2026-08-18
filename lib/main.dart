import 'dart:io';

import 'package:messenger/models/app_settings.dart';
import 'package:messenger/providers/settings_provider.dart';
import 'package:messenger/services/settings_service.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:path_provider/path_provider.dart';
import 'package:messenger/generated/l10n.dart';
import 'package:messenger/screens/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Path where hive can save data
  final appSupportDir = await getApplicationSupportDirectory();
  final messengerDir = Directory(p.join(appSupportDir.path, "messenger"));

  if (!await messengerDir.exists()) {
    await messengerDir.create(recursive: true);
  }

  /// Init hive
  Hive.init(messengerDir.path);
  Hive.registerAdapter(AppSettingsAdapter());

  runApp(const Messenger());
}

class Messenger extends StatelessWidget {
  const Messenger({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(SettingsService())..loadSettings(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return MaterialApp(
            /// AppTitle
            onGenerateTitle: (context) => S.of(context).appTitle,

            /// Localization
            locale: Locale(settingsProvider.languageCode),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            /// Themes
            themeMode: settingsProvider.currentTheme,

            /// Theme light
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: settingsProvider.accentColor,
                brightness: Brightness.light,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                  backgroundColor: Color(0xFFF2F2F2),
                  iconColor: Colors.black,
                  shadowColor: Colors.transparent
                ),
              ),
              useMaterial3: true,
            ),

            /// Theme dark
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF1A1A1D),
              colorScheme: ColorScheme.fromSeed(
                seedColor: settingsProvider.accentColor,
                brightness: Brightness.dark,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Color(0xFF161616),
                  iconColor: Colors.white,
                ),
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
