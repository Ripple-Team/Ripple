// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'dart:convert';

import 'package:hive_ce/hive_ce.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Provides (and lazily generates) the AES key used to encrypt local Hive boxes
class SecureKeyStore {
  static const _keyName = "hive_encryption_key";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<int>> getEncryptionKey() async {
    final existing = await _storage.read(key: _keyName);
    if (existing != null) {
      return base64Decode(existing);
    }

    final newKey = Hive.generateSecureKey();
    await _storage.write(key: _keyName, value: base64Encode(newKey));
    return newKey;
  }
}