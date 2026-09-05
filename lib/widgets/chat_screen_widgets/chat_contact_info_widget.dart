// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

import 'package:ripple/extensions/theme_data_ext.dart';

/// Displays the chat partner's avatar, name, and last-seen status.
///
/// Tapping navigates to the partner's profile screen.
class ChatContactInfoWidget extends StatelessWidget {
  const ChatContactInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        onTap: () {
          // TODO: GO TO PROFILE
        },
        borderRadius: BorderRadius.circular(100),
        child: Row(
          children: [
            const Icon(Icons.account_circle_rounded, size: 50),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Ivan", style: TextStyle(fontSize: 18),),
                  Text(
                    "was online in 13 aug. at 10:10",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}