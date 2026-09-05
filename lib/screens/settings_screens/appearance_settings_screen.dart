// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/widgets/settings_widgets/settings_section.dart';
import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/utils/theme_mode.dart';
import 'package:ripple/generated/l10n.dart';
import 'package:ripple/utils/colors.dart';

/// Screen for customizing the app's appearance.
///
/// Allows the user to pick a theme mode (system/light/dark)
/// and an accent color from the predefined [accentColors] palette.
class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final theme = Theme.of(context);
    final s = S.of(context);

    final shadowColor = theme.brightness == Brightness.dark
        ? Colors.white.withAlpha(200)
        : const Color(0xFFABA9AF);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.settings_appearance_title),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        body: ListView(
          children: [
            SettingsSection(
              children: [
                _buildThemeMode(context, s, settings),
                _buildAccentColors(context, s, settings, shadowColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeMode(BuildContext context, S s, SettingsProvider settings) {
    final dropDownThemeFocus = FocusNode();

    return ListTile(
      title: Text(s.settings_tab_themeMode_title),
      trailing: DropdownButton<AppThemeMode>(
        focusNode: dropDownThemeFocus,
        underline: const SizedBox.shrink(),
        value: settings.currentTheme,
        items: [
          DropdownMenuItem(
            value: AppThemeMode.system,
            child: Text(s.settings_tab_themeMode_system),
          ),
          DropdownMenuItem(
            value: AppThemeMode.light,
            child: Text(s.settings_tab_themeMode_light),
          ),
          DropdownMenuItem(
            value: AppThemeMode.dark,
            child: Text(s.settings_tab_themeMode_dark),
          ),
        ],
        onChanged: (newValue) {
          settings.setTheme(newValue!);
          dropDownThemeFocus.unfocus();
        },
        onTap: FocusScope.of(context).unfocus,
      ),
    );
  }

  Widget _buildAccentColors(
    BuildContext context,
    S s,
    SettingsProvider settings,
    Color shadowColor,
  ) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(s.settings_tab_accentColor_title),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 12),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: accentColors.map((color) {
            final isSelected =
                settings.accentColor.toARGB32() == color.toARGB32();
            return InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () => settings.setAccentColor(color),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: shadowColor,
                            offset: const Offset(0, 0),
                            spreadRadius: 4,
                            blurRadius: 5,
                          ),
                        ]
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
