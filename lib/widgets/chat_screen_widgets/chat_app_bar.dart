import 'package:flutter/material.dart';

import 'package:ripple/widgets/chat_screen_widgets/chat_contact_info_widget.dart';
import 'package:ripple/widgets/circle_icon_button.dart';

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
          CircleIconButton(
            icon: const Icon(Icons.arrow_back_rounded, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const ChatContactInfoWidget(),
          CircleIconButton(
            icon: const Icon(Icons.more_vert_rounded, size: 25),
            onPressed: () {
              // TODO: more info
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
