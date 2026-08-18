import 'package:flutter/material.dart';
import 'package:messenger/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'package:messenger/providers/settings_provider.dart';
import 'package:messenger/utils/utils.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final settings = context.read<SettingsProvider>();

    return Row(
      children: [
        /// Text Field
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: emoji
                  },
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  padding: const EdgeInsets.only(left: 4),
                ),

                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    maxLines: null,
                    onChanged: (_) {
                      setState(() {});
                    },
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: s.chat_screen_text_field_hint_text,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                if (_controller.text.isEmpty)
                  IconButton(
                    onPressed: () {
                      // TODO: attach
                    },
                    icon: const Icon(Icons.attach_file_rounded),
                    padding: const EdgeInsets.only(right: 4),
                  ),
              ],
            ),
          ),
        ),

        /// Send Button
        ElevatedButton(
          onPressed: () {
            _controller.clear();
            _focusNode.unfocus();
            // TODO: send message
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: settings.accentColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(Icons.send_rounded, color: Colors.white),
        ),
      ],
    );
  }
}
