import 'package:flutter/material.dart';

import 'package:messenger/widgets/tab_chats/chat_list_widget.dart';
import 'package:messenger/widgets/home_screen/search_widget.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchWidget(),
        Expanded(child: ChatListWidget()),
      ],
    );
  }
}
