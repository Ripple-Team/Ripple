import 'package:ripple/utils/message_utils.dart';

/// A chat message in a conversation.
///
/// Represents a single message sent by a user, containing text content
/// and metadata like delivery [status] and [time].
class Message {
  final String id;
  final String text;
  final String senderId;
  final DateTime time;
  final MessageStatus status;

  Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.time,
    this.status = MessageStatus.sent,
  });

  /// Creates a copy of this message with the given fields replaced.
  ///
  /// Any omitted parameter retains the current value.
  Message copyWith({
    String? id,
    String? text,
    String? senderId,
    DateTime? time,
    MessageStatus? status,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }
}
