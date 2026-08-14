import 'package:flutter/material.dart';

import 'package:messager/widgets/chat_list_widget.dart';
import 'package:messager/widgets/search_widget.dart';

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
