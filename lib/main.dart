// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:ripple/repositories/interfaces/contact_repository.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/repositories/interfaces/session_repository.dart';
import 'package:ripple/repositories/interfaces/chat_repository.dart';
import 'package:ripple/repositories/interfaces/auth_repository.dart';
import 'package:ripple/providers/chat_list_provider.dart';
import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/providers/auth_provider.dart';
import 'package:ripple/screens/auth_screen.dart';
import 'package:ripple/generated/l10n.dart';
import 'package:ripple/screens/home.dart';
import 'package:ripple/di.dart';
import 'package:ripple/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Messenger(deps: await initDependencies()));
}

/// The root widget of the Ripple application.
///
/// Wires up global providers, localization, and themes before
/// delegating to either the [AuthScreen] or [Home] screen.
class Messenger extends StatelessWidget {
  final AppDependencies deps;

  const Messenger({super.key, required this.deps});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(deps.settingsRepository),
        ),
        Provider<AuthRepository>(create: (_) => deps.authRepository),
        Provider<SessionRepository>(create: (_) => deps.sessionRepository),
        Provider<MessageRepository>(
          create: (_) => deps.messageRepository,
          dispose: (_, repository) => repository.dispose(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            context.read<AuthRepository>(),
            context.read<SessionRepository>(),
          ),
        ),
        Provider<ContactRepository>(
          create: (_) => deps.contactRepository,
          dispose: (_, repo) => repo.dispose(),
        ),
        Provider<ChatRepository>(
          create: (_) => deps.chatRepository,
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
            theme: lightTheme(settingsProvider.accentColor),
            darkTheme: darkTheme(settingsProvider.accentColor),

            home: auth.isLoggedIn ? const Home() : const AuthScreen(),
          );
        },
      ),
    );
  }
}
