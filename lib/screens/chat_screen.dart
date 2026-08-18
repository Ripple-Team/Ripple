import 'package:flutter/material.dart';

import 'package:messenger/widgets/chat_screen_widgets/list_messages_widget.dart';
import 'package:messenger/widgets/chat_screen_widgets/chat_text_field.dart';
import 'package:messenger/widgets/chat_screen_widgets/chat_app_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: ChatAppBar(),
        body: Column(
          children: [
            ListMessagesWidget(),
            SafeArea(child: ChatTextField()),
          ],
        ),
      ),
    );
  }
}
