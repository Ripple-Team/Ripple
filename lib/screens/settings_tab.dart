import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/utils/theme_mode.dart';
import 'package:ripple/generated/l10n.dart';
import 'package:ripple/utils/colors.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final s = S.of(context);

    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Column(
        children: [
          /// Theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.settings_tab_themeMode_title),
              DropdownButton<AppThemeMode>(
                mouseCursor: SystemMouseCursors.click,
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
                onChanged: (newValue) => settings.setTheme(newValue!),
              ),
            ],
          ),
          const Divider(),

          /// Accent color
          Text(s.settings_tab_accentColor_title),
          SizedBox(height: 15),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: accentColors.map((color) {
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
                    border: settings.accentColor == color
                        ? Border.all(color: Colors.white, width: 2)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          const Divider(),

          /// Language
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.settings_tab_language_title),
              DropdownButton<String>(
                mouseCursor: SystemMouseCursors.click,
                value: settings.languageCode,
                items: [
                  DropdownMenuItem(value: "en", child: Text(s.english)),
                  DropdownMenuItem(value: "ru", child: Text(s.russian)),
                ],
                onChanged: (newValue) => settings.setLanguage(newValue!),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
