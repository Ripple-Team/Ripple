import 'package:flutter/cupertino.dart';
import 'package:ripple/generated/l10n.dart';
import 'package:ripple/widgets/tab_chats/chat_preview.dart';

/// Displays the list of user's chat conversations.
///
/// Shows a placeholder message when no chats exist.
class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final testItems = [1];
    if (testItems.isEmpty) return Center(child: Text(s.no_chats));

    return ListView.builder(
      itemCount: testItems.length,
      itemBuilder: (context, index) {
        return ChatPreview(chatId: "chat_123",); // TODO: real chat id
      },
    );
  }
}