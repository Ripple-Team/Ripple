import 'package:flutter/material.dart';

import 'package:ripple/generated/l10n.dart';

class ContactsBar extends StatelessWidget {
  const ContactsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Center(child: Text(s.bar_contacts));
  }
}
