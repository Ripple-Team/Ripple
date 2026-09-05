// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';

import 'package:ripple/widgets/tab_chats/chat_list_widget.dart';
import 'package:ripple/widgets/home_screen/search_widget.dart';

/// Tab displaying the list of chats with a search bar.
class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchWidget(),
        Expanded(child: ChatListWidget()),
      ],
    );
  }
}
