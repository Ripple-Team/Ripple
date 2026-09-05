// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

import 'package:ripple/extensions/theme_data_ext.dart';

/// Groups multiple settings rows into a rounded card container.
class SettingsSection extends StatelessWidget {
  /// The settings rows to display inside the card.
  final List<Widget> children;

  const SettingsSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: theme.colorScheme.secondaryBackground,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Column(children: children),
      ),
    );
  }
}
