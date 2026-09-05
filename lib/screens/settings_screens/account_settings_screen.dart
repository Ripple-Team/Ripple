// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ripple/providers/auth_provider.dart';

import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/generated/l10n.dart';

/// Screen for managing the current user's account.
///
/// Currently contains only a logout button; profile editing
/// will be added later (see TODO).
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);
    final s = S.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.settings_account_title),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              Text("Todo: account settings"), // TODO: account settings
              ElevatedButton.icon(
                onPressed: () {
                  auth.logout();
                  Navigator.pop(context);
                },
                label: Text(s.settings_account_logout),
                icon: Icon(Icons.logout_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
