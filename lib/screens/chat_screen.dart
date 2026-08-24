import 'package:flutter/material.dart';
import 'package:messenger/providers/chat_provider.dart';
import 'package:messenger/repositories/mock_message_repository.dart';

import 'package:messenger/widgets/chat_screen_widgets/list_messages_widget.dart';
import 'package:messenger/widgets/chat_screen_widgets/chat_text_field.dart';
import 'package:messenger/widgets/chat_screen_widgets/chat_app_bar.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(MockMessageRepository(), "chat_123"),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: ChatAppBar(),
          body: Column(
            children: [
              const ListMessagesWidget(),
              const ChatTextField()
            ],
          ),
        ),
      ),
    );
  }
}
