import 'package:flutter/material.dart';

import 'package:ripple/widgets/tab_chats/chat_list_widget.dart';
import 'package:ripple/widgets/home_screen/search_widget.dart';

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
