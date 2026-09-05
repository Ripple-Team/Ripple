import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:hive_ce/hive_ce.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ripple/data_sources/hive_message_cache_data_source.dart';
import 'package:ripple/repositories/interfaces/settings_repository.dart';
import 'package:ripple/repositories/interfaces/contact_repository.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/repositories/interfaces/session_repository.dart';
import 'package:ripple/repositories/interfaces/auth_repository.dart';
import 'package:ripple/repositories/interfaces/chat_repository.dart';
import 'package:ripple/repositories/hive_settings_repository.dart';
import 'package:ripple/repositories/hive_session_repository.dart';
import 'package:ripple/repositories/mock_contact_repository.dart';
import 'package:ripple/repositories/mock_message_repository.dart';
import 'package:ripple/repositories/mock_auth_repository.dart';
import 'package:ripple/repositories/mock_chat_repository.dart';
import 'package:ripple/services/secure_key_store.dart';
import 'package:ripple/models/app_settings.dart';
import 'package:ripple/utils/message_utils.dart';
import 'package:ripple/utils/theme_mode.dart';
import 'package:ripple/models/message.dart';

class AppDependencies {
  final Box<AppSettings> settingsBox;
  final Box<String> sessionBox;
  final Box messagesBox;

  final SettingsRepository settingsRepository;
  final AuthRepository authRepository;
  final SessionRepository sessionRepository;
  final MessageRepository messageRepository;
  final ChatRepository chatRepository;
  final ContactRepository contactRepository;

  AppDependencies({
    required this.settingsBox,
    required this.sessionBox,
    required this.messagesBox,
    required this.authRepository,
    required this.chatRepository,
    required this.contactRepository,
    required this.sessionRepository,
    required this.messageRepository,
    required this.settingsRepository,
  });
}

Future<AppDependencies> initDependencies() async {
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

  // boxes
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

  // repositories
  final authRepository = MockAuthRepository();
  final chatRepository = MockChatRepository();
  final contactRepository = MockContactRepository();
  final sessionRepository = HiveSessionRepository(sessionBox);
  final settingsRepository = HiveSettingsRepository(settingsBox);
  final messageRepository = MockMessageRepository(
    HiveMessageCacheDataSource(messagesBox),
  );

  return AppDependencies(
    settingsBox: settingsBox,
    sessionBox: sessionBox,
    messagesBox: messagesBox,
    authRepository: authRepository,
    chatRepository: chatRepository,
    contactRepository: contactRepository,
    sessionRepository: sessionRepository,
    messageRepository: messageRepository,
    settingsRepository: settingsRepository,
  );
}
