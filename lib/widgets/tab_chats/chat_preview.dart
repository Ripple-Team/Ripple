import 'package:flutter/material.dart';
import 'package:messenger/screens/chat_screen.dart';

// TODO: work
class ChatPreview extends StatefulWidget {
  const ChatPreview({super.key});

  @override
  State<ChatPreview> createState() => _ChatPreviewState();
}

class _ChatPreviewState extends State<ChatPreview> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          //   TODO: GO TO PROFILE
        },
        icon: Icon(Icons.person, size: 50),
      ),
      title: Text("Ivan"),
      subtitle: Text(
        "Lorem ipsum dolor aodo fosai pggor najjf sd",
        style: TextStyle(
          color: Color(0xFF666666),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Text(
        "8:30",
        style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ChatScreen())
        );
      },
    );
  }
}
