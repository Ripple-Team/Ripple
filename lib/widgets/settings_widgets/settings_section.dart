import 'package:flutter/material.dart';

import 'package:ripple/extensions/theme_data_ext.dart';

class SettingsSection extends StatelessWidget {
  final List<Widget> children;

  const SettingsSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        // color: theme.secondaryBackground,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Column(children: children),
      ),
    );
  }
}
