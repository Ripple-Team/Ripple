// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

import 'package:ripple/generated/l10n.dart';

/// Placeholder tab showing the contacts list.
class ContactsBar extends StatelessWidget {
  const ContactsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Center(child: Text(s.bar_contacts));
  }
}
