import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/repositories/interfaces/contact_repository.dart';
import 'package:ripple/repositories/interfaces/message_repository.dart';
import 'package:ripple/providers/chat_preview_provider.dart';
import 'package:ripple/screens/chat_screen.dart';
import 'package:ripple/utils/time_utils.dart';
import 'package:ripple/models/chat.dart';

/// Preview tile for a single chat in the conversations list.
///
/// Tapping navigates to the full [ChatScreen] for the given [chatId].
class ChatPreview extends StatelessWidget {
  final Chat chat;

  const ChatPreview({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final contact = context.read<ContactRepository>().getContact(chat.contactId);

    return ChangeNotifierProvider(
      create: (context) =>
          ChatPreviewProvider(context.read<MessageRepository>(), chat.id),
      child: Consumer<ChatPreviewProvider>(
        builder: (context, preview, _) {
          final lastMessage = preview.lastMessage;

          return ListTile(
            leading: IconButton(
              onPressed: () {
                //   TODO: GO TO PROFILE
              },
              icon: const Icon(Icons.person, size: 50), // TODO: make contact
            ),
            title: Text(contact?.name ?? '-'),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                lastMessage?.text ?? "",
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF666666),
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15
                ),
              ),
            ),
            trailing: Text(
              lastMessage != null ? formatTime(lastMessage.time) : "",
              style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatScreen(chatId: chat.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
