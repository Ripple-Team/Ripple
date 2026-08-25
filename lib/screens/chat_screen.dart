import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/widgets/chat_screen_widgets/list_messages_widget.dart';
import 'package:ripple/widgets/chat_screen_widgets/chat_text_field.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/widgets/chat_screen_widgets/chat_app_bar.dart';
import 'package:ripple/providers/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ChatProvider(context.read<MessageRepository>(), chatId),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: ChatAppBar(),
          body: const Column(children: [ListMessagesWidget(), ChatTextField()]),
        ),
      ),
    );
  }
}
