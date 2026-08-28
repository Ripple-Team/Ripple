import 'package:flutter/material.dart';

/// Brand-specific colors not available in Flutter's standard [ColorScheme].
///
/// These are used for backgrounds that need to visually separate
/// from the scaffold while still respecting the current theme brightness.
extension CustomAppColors on ColorScheme {
  /// A subtle background color used for elevated containers like
  /// [CircleIconButton] and input fields.
  ///
  /// * Light mode: soft gray (`#F2F2F2`)
  /// * Dark mode: deep gray (`#161616`)
  Color get secondaryBackground =>
      brightness == Brightness.dark ? const Color(0xFF161616) : const Color(0xFFF2F2F2);
}