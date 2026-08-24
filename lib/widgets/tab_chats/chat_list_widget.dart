import 'package:flutter/cupertino.dart';
import 'package:messenger/generated/l10n.dart';
import 'package:messenger/widgets/tab_chats/chat_preview.dart';

/// List all chats
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
        return ChatPreview();
      },
    );
  }
}