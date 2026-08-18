import 'package:flutter/cupertino.dart';
import 'package:messenger/generated/l10n.dart';
import 'package:messenger/widgets/tab_chats/chat_preview.dart';

/// List all chats
class ChatListWidget extends StatefulWidget {
  const ChatListWidget({super.key});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final testItems = [1];

    return ListView.builder(
      itemCount: testItems.length,
      itemBuilder: (context, index) {
        if (testItems.isEmpty) return Center(child: Text(s.noChats));

        return ChatPreview();
      },
    );
  }
}
