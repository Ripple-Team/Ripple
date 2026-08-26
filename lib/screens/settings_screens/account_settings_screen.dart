import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/generated/l10n.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final theme = Theme.of(context);
    final s = S.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.settings_account_title),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        body: ListView(children: []),
      ),
    );
  }
}
