// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

/// Tab icon with a title, used in the home screen's bottom navigation bar.
class BarIcon extends StatelessWidget {
  /// Title displayed below the icon.
  final String title;

  /// Icon to display.
  final Icon icon;

  const BarIcon({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("("),
              const SizedBox(width: 5),
              icon,
              const SizedBox(width: 5),
              Text(")"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
