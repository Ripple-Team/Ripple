import 'package:flutter/material.dart';
import 'package:messenger/utils/utils.dart';

class ChatContactInfoWidget extends StatefulWidget {
  const ChatContactInfoWidget({super.key});

  @override
  State<ChatContactInfoWidget> createState() => _ChatContactInfoWidgetState();
}

class _ChatContactInfoWidgetState extends State<ChatContactInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        onTap: () {
          // TODO: GO TO PROFILE
        },
        borderRadius: BorderRadius.circular(100),
        child: Row(
          children: [
            Icon(Icons.account_circle_rounded, size: 50),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Ivan", style: TextStyle(fontSize: 18),),
                  Text(
                    "was online in 13 aug. at 10:10",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
