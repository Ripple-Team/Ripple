// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:hive_ce/hive_ce.dart';
import 'package:flutter/material.dart';

// TODO: mb put it in dir 'adapters'?

/// Application theme mode that can be persisted in Hive.
///
/// Maps to Flutter's [ThemeMode] via [toFlutter] method.
enum AppThemeMode {
  system,
  light,
  dark;

  /// Converts this enum to Flutter's [ThemeMode].
  ThemeMode toFlutter() => switch (this) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };
}

/// Hive type adapter for [AppThemeMode] enum.
class AppThemeModeAdapter extends TypeAdapter<AppThemeMode> {
  @override
  final int typeId = 1;

  @override
  AppThemeMode read(BinaryReader reader) {
    final byte = reader.readByte();
    return byte < AppThemeMode.values.length
        ? AppThemeMode.values[byte]
        : AppThemeMode.system;
  }

  @override
  void write(BinaryWriter writer, AppThemeMode obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppThemeModeAdapter && typeId == other.typeId;
}
