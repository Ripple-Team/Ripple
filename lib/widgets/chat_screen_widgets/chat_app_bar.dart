import 'package:flutter/material.dart';

import 'package:messenger/widgets/chat_screen_widgets/chat_contact_info_widget.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 73,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            child: Icon(Icons.arrow_back_rounded, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ChatContactInfoWidget(),
          ElevatedButton(
            onPressed: () {
              // TODO: more info
            },
            child: Icon(Icons.more_vert_rounded, size: 25),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
