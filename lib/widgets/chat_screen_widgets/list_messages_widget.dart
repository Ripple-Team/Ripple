import 'package:flutter/material.dart';
import 'package:ripple/extensions/message_ext.dart';
import 'package:provider/provider.dart';

import 'package:ripple/widgets/chat_screen_widgets/message_bubble.dart';
import 'package:ripple/providers/auth_provider.dart';
import 'package:ripple/providers/chat_provider.dart';

/// Scrollable list of chat messages with automatic bottom-scrolling.
///
/// Groups consecutive messages from the same sender visually
/// by adjusting the bubble border radius.
class ListMessagesWidget extends StatefulWidget {
  const ListMessagesWidget({super.key});

  @override
  State<ListMessagesWidget> createState() => _ListMessagesWidgetState();
}

class _ListMessagesWidgetState extends State<ListMessagesWidget> {
  final ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final auth = context.watch<AuthProvider>();

    if (chatProvider.isLoading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    final messages = chatProvider.messages;

    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final messageIndex = messages.length - 1 - index;
          final message = messages[messageIndex];

          final previousMessage = messageIndex > 0
              ? messages[messageIndex - 1]
              : null;

          final isConsecutive =
              previousMessage != null &&
              previousMessage.senderId == message.senderId;

          final isMe = message.isMine(auth.currentUserId ?? '');
          return MessageBubble(
            message: message,
            isConsecutive: isConsecutive,
            isMe: isMe,
          );
        },
      ),
    );
  }
}
