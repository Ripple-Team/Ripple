import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:hive_ce/hive_ce.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ripple/services/secure_key_store.dart';
import 'package:ripple/models/app_settings.dart';
import 'package:ripple/utils/message_utils.dart';
import 'package:ripple/utils/theme_mode.dart';
import 'package:ripple/models/message.dart';

class AppDependencies {
  final Box<AppSettings> settingsBox;
  final Box<String> sessionBox;
  final Box messagesBox;

  AppDependencies({
    required this.settingsBox,
    required this.sessionBox,
    required this.messagesBox,
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

  return AppDependencies(
    settingsBox: settingsBox,
    sessionBox: sessionBox,
    messagesBox: messagesBox,
  );
}
