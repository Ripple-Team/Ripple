// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:ripple/data_sources/hive_message_cache_data_source.dart';
import 'package:ripple/repositories/interfaces/contact_repository.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/repositories/interfaces/session_repository.dart';
import 'package:ripple/repositories/interfaces/chat_repository.dart';
import 'package:ripple/repositories/interfaces/auth_repository.dart';
import 'package:ripple/repositories/hive_settings_repository.dart';
import 'package:ripple/repositories/mock_contact_repository.dart';
import 'package:ripple/repositories/mock_message_repository.dart';
import 'package:ripple/repositories/hive_session_repository.dart';
import 'package:ripple/repositories/mock_auth_repository.dart';
import 'package:ripple/repositories/mock_chat_repository.dart';
import 'package:ripple/providers/chat_list_provider.dart';
import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/providers/auth_provider.dart';
import 'package:ripple/models/app_settings.dart';
import 'package:ripple/screens/auth_screen.dart';
import 'package:ripple/generated/l10n.dart';
import 'package:ripple/screens/home.dart';
import 'package:ripple/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final deps = await initDependencies();
  runApp(
    Messenger(
      settingsBox: deps.settingsBox,
      sessionBox: deps.sessionBox,
      messagesBox: deps.messagesBox,
    ),
  );
}

/// The root widget of the Ripple application.
///
/// Configures global providers, localization, and themes before
/// delegating to either the [AuthScreen] or [Home] screen.
class Messenger extends StatelessWidget {
  final Box<AppSettings> settingsBox;
  final Box<String> sessionBox;
  final Box messagesBox;

  const Messenger({
    super.key,
    required this.settingsBox,
    required this.sessionBox,
    required this.messagesBox,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(HiveSettingsRepository(settingsBox)),
        ),
        Provider<AuthRepository>(create: (_) => MockAuthRepository()),
        Provider<SessionRepository>(
          create: (_) => HiveSessionRepository(sessionBox),
        ),
        Provider<MessageRepository>(
          create: (_) => MockMessageRepository(HiveMessageCacheDataSource(messagesBox)),
          dispose: (_, repository) => repository.dispose(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            context.read<AuthRepository>(),
            context.read<SessionRepository>(),
          ),
        ),
        Provider<ContactRepository>(
          create: (_) => MockContactRepository(),
          dispose: (_, repo) => repo.dispose(),
        ),
        Provider<ChatRepository>(
          create: (_) => MockChatRepository(),
          dispose: (_, repo) => repo.dispose(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatListProvider(context.read<ChatRepository>()),
        ),
      ],
      child: Consumer2<SettingsProvider, AuthProvider>(
        builder: (context, settingsProvider, auth, _) {
          return MaterialApp(
            onGenerateTitle: (context) => S.of(context).app_title,

            locale: Locale(settingsProvider.languageCode),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            themeMode: settingsProvider.currentTheme.toFlutter(),

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: settingsProvider.accentColor,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),

            darkTheme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF1A1A1D),
              colorScheme: ColorScheme.fromSeed(
                seedColor: settingsProvider.accentColor,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),

            home: auth.isLoggedIn ? const Home() : const AuthScreen(),
          );
        },
      ),
    );
  }
}
