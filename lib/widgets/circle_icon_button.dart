// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

import 'package:ripple/extensions/theme_data_ext.dart';

/// A circular [ElevatedButton] widget that display [Icon].
///
/// Automatically adapts its foreground and background colors based on the
/// current theme brightness (light or dark mode).
class CircleIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;

  const CircleIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color color = theme.brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        backgroundColor: theme.colorScheme.secondaryBackground,
        foregroundColor: color,
        shadowColor: Colors.transparent,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
