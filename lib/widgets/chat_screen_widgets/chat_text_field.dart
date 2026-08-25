import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/extensions/theme_data_ext.dart';
import 'package:ripple/providers/chat_provider.dart';
import 'package:ripple/generated/l10n.dart';

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
    final settings = context.watch<SettingsProvider>();

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
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: s.chat_screen_text_field_hint_text,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    return value.text.isEmpty
                        ? IconButton(
                            onPressed: () {
                              // TODO: attach
                            },
                            icon: const Icon(Icons.attach_file_rounded),
                            padding: const EdgeInsets.only(right: 4),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),

        /// Send Button
        ElevatedButton(
          onPressed: () {
            final text = _controller.text.trim();
            if (text.isEmpty) return;

            context.read<ChatProvider>().sendMessage(text);

            _controller.clear();
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
