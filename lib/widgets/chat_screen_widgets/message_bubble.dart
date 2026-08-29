import 'package:flutter/material.dart';

import 'package:ripple/utils/message_utils.dart';
import 'package:ripple/utils/time_utils.dart';
import 'package:ripple/models/message.dart';

/// A single message bubble in a chat conversation.
///
/// Renders on the right side for the current user's messages,
/// and on the left side for messages from others. Shows a timestamp
/// and delivery status icon for outgoing messages.
class MessageBubble extends StatelessWidget {
  /// The message to display.
  final Message message;

  /// Whether this message immediately follows another from the same sender.
  ///
  /// Used to visually group messages by reducing the inner border radius.
  final bool isConsecutive;

  /// Whether this message was sent by the current user.
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isConsecutive,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bubbleColor = isMe
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;

    final textColor = isMe
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurface;

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isMe ? 16 : (isConsecutive ? 4 : 16)),
      bottomRight: Radius.circular(isMe ? (isConsecutive ? 4 : 16) : 16),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.text,
                  style: TextStyle(color: textColor, fontSize: 15, height: 1.3),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      formatTime(message.time),
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),

                    if (isMe) ...[
                      const SizedBox(width: 4),
                      Icon(
                        switch (message.status) {
                          MessageStatus.sending => Icons.access_time_rounded,
                          MessageStatus.sent => Icons.check_rounded,
                          MessageStatus.read => Icons.done_all_rounded,
                        },
                        size: 14,
                        color: message.status == MessageStatus.read
                            ? theme.colorScheme.primary
                            : textColor.withValues(alpha: 0.5),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
