import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ripple/providers/chat_list_provider.dart';
import 'package:ripple/repositories/interfaces/chat_repository.dart';

import 'package:ripple/repositories/interfaces/contact_repository.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/repositories/interfaces/session_repository.dart';
import 'package:ripple/repositories/interfaces/auth_repository.dart';
import 'package:ripple/repositories/hive_settings_repository.dart';
import 'package:ripple/repositories/mock_chat_repository.dart';
import 'package:ripple/repositories/mock_contact_repository.dart';
import 'package:ripple/repositories/mock_message_repository.dart';
import 'package:ripple/repositories/hive_session_repository.dart';
import 'package:ripple/repositories/mock_auth_repository.dart';
import 'package:ripple/repositories/hive_message_cache.dart';
import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/services/secure_key_store.dart';
import 'package:ripple/providers/auth_provider.dart';
import 'package:ripple/models/app_settings.dart';
import 'package:ripple/screens/auth_screen.dart';
import 'package:ripple/utils/message_utils.dart';
import 'package:ripple/utils/theme_mode.dart';
import 'package:ripple/generated/l10n.dart';
import 'package:ripple/models/message.dart';
import 'package:ripple/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Isolate Hive storage in dedicated subfolder
  final appSupportDir = await getApplicationSupportDirectory();
  final messengerDir = Directory(p.join(appSupportDir.path, "ripple"));

  if (!await messengerDir.exists()) {
    await messengerDir.create(recursive: true);
  }

  Hive.init(messengerDir.path);
  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(AppThemeModeAdapter());
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(MessageStatusAdapter());

  final keyProvider = SecureKeyStore();
  final encryptionKey = await keyProvider.getEncryptionKey();
  final cipher = HiveAesCipher(encryptionKey);

  final Box<AppSettings> settingsBox = await Hive.openBox<AppSettings>(
    "settings",
  );
  final Box<String> sessionBox = await Hive.openBox<String>(
    "session",
    encryptionCipher: cipher,
  );
  final messagesBox = await Hive.openBox(
    "messages_cache",
    encryptionCipher: cipher,
  );

  runApp(
    Messenger(
      settingsBox: settingsBox,
      sessionBox: sessionBox,
      messagesBox: messagesBox,
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
          create: (_) => MockMessageRepository(HiveMessageCache(messagesBox)),
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
