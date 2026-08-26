import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/screens/settings_screens/appearance_settings_screen.dart';
import 'package:ripple/screens/settings_screens/account_settings_screen.dart';
import 'package:ripple/widgets/settings_widgets/settings_section.dart';
import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/providers/auth_provider.dart';
import 'package:ripple/generated/l10n.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final auth = context.watch<AuthProvider>();
    final s = S.of(context);
    final theme = Theme.of(context);

    return ListView(
      children: [
        // --- HEADER ---
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              const Icon(Icons.account_circle_rounded, size: 100),
              // TODO: profile image
              const SizedBox(height: 8),
              Text(
                auth.currentUserId ?? "none",
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ),

        // --- SETTINGS ---
        SettingsSection(
          children: [
            // Account
            ListTile(
              leading: const Icon(Icons.account_circle_rounded, size: 30),
              title: Text(s.settings_account_title),
              subtitle: Text(s.settings_account_subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AccountSettingsScreen(),
                ),
              ),
            ),

            // Theme
            ListTile(
              leading: const Icon(Icons.format_paint_outlined),
              title: Text(s.settings_appearance_title),
              subtitle: Text(s.settings_appearance_subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AppearanceSettingsScreen(),
                ),
              ),
            ),

            const Divider(height: 1, indent: 16, endIndent: 16),

            // Language
            _buildLanguageSettings(context, s, settings),
          ],
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildLanguageSettings(
    BuildContext context,
    S s,
    SettingsProvider settings,
  ) {
    return ListTile(
      title: Text(s.settings_tab_language_title),
      trailing: DropdownButton<String>(
        underline: const SizedBox(),
        value: settings.languageCode,
        items: [
          DropdownMenuItem(value: "en", child: Text(s.english)),
          DropdownMenuItem(value: "ru", child: Text(s.russian)),
        ],
        onChanged: (newValue) => settings.setLanguage(newValue!),
      ),
    );
  }
}