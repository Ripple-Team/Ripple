import 'package:flutter/material.dart';

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

extension CustomAppColors on ThemeData {
  Color get secondaryBackground => brightness == Brightness.dark
      ? Color(0xFF161616)
      : Color(0xFFF2F2F2);
}