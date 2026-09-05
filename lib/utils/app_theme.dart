// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

/// Builds the light application theme from a [seed] color.
///
/// Material 3 derives the full color scheme (primary, surface,
/// container colors, etc.) from this single seed.
ThemeData lightTheme(Color seed) => ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
  useMaterial3: true,
);

/// Builds the dark application theme from a [seed] color.
ThemeData darkTheme(Color seed) => ThemeData(
  scaffoldBackgroundColor: const Color(0xFF1A1A1D),
  colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
  useMaterial3: true,
);