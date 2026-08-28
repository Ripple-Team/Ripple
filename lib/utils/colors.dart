import 'package:flutter/material.dart';

/// Predefined palette of accent colors available for app customization.
///
/// Used in the settings screen to let the user pick a custom [Color]
/// for the app's primary accent. The selected color is stored in
/// [AppSettings] and applied via [SettingsProvider].
const List<Color> accentColors = [
  Colors.deepPurple,
  Colors.cyan,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.red,
  Colors.pink,
];