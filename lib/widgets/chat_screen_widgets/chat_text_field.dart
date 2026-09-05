// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ripple/providers/settings_provider.dart';
import 'package:ripple/extensions/theme_data_ext.dart';
import 'package:ripple/providers/chat_provider.dart';
import 'package:ripple/models/message.dart';
import 'package:ripple/generated/l10n.dart';

/// Text input field for sending messages in a chat.
///
/// Shows emoji and attachment buttons when empty,
/// and a send button when text is entered.
///
/// Also supports editing an existing message: while
/// [ChatProvider.editingMessage] is set, the field is prefilled with
/// the message text and the send button acts as "save changes".
class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /// Id of the message currently loaded into the field for editing.
  ///
  /// Guards against overwriting the controller on unrelated rebuilds
  /// (e.g. when a new message arrives while the user is typing an edit).
  String? _lastEditedId;

  static const double _maxInputHeight = 140;

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

    // Edit mode: watch the provider and keep the field in sync
    final chatProvider = context.watch<ChatProvider>();
    final editing = chatProvider.editingMessage;

    if (editing != null && _lastEditedId != editing.id) {
      // Entered edit mode: prefill the field and focus it.
      // The controller is touched after the frame, because changing it
      // mid-build would notify listeners during the current build.
      _lastEditedId = editing.id;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = editing.text;
        _focusNode.requestFocus();
      });
    } else if (editing == null && _lastEditedId != null) {
      // Left edit mode (cancel or successful save): clear the field.
      _lastEditedId = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.clear();
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (editing != null) _buildEditingBanner(theme, editing),

        // Existing input row, unchanged except for the send button.
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: _maxInputHeight),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryBackground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          minLines: 1,
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
            ),

            // Send / confirm button
            ElevatedButton(
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isEmpty) return;

                final provider = context.read<ChatProvider>();
                final editingMessage = provider.editingMessage;

                if (editingMessage != null) {
                  provider.editMessage(editingMessage.id, text);
                } else {
                  provider.sendMessage(text);
                }

                _controller.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.accentColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
              ),
              child: Icon(
                editing != null ? Icons.check_rounded : Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// "Editing" banner shown above the field while editing a message.
  Widget _buildEditingBanner(ThemeData theme, Message message) {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
      child: Row(
        children: [
          Icon(Icons.edit_rounded, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.chat_screen_editing_title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  message.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 18),
            onPressed: () => context.read<ChatProvider>().cancelEditing(),
          ),
        ],
      ),
    );
  }
}
