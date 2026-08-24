import 'package:flutter/material.dart';

extension CustomAppColors on ThemeData {
  Color get secondaryBackground =>
      brightness == Brightness.dark ? Color(0xFF161616) : Color(0xFFF2F2F2);
}