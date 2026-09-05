// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/widgets/tab_chats/chat_preview.dart';
import 'package:ripple/providers/chat_list_provider.dart';
import 'package:ripple/generated/l10n.dart';

/// Displays the list of user's chat conversations.
///
/// Shows a placeholder message when no chats exist.
class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final chats = context.watch<ChatListProvider>().chats;

    if (chats.isEmpty) return Center(child: Text(s.no_chats));

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatPreview(chat: chats[index],);
      },
    );
  }
}