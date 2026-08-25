import 'package:flutter/material.dart';

import 'package:ripple/extensions/theme_data_ext.dart';

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
        backgroundColor: theme.secondaryBackground,
        foregroundColor: color,
        shadowColor: Colors.transparent,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
