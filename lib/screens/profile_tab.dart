// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

import 'package:ripple/generated/l10n.dart';

/// Placeholder tab for the user's profile.
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Center(child: Text(s.bar_profile),);
  }
}
