import 'package:hive/hive.dart';

import 'package:ripple/utils/message_utils.dart';

part 'message.g.dart';

/// A chat message in a conversation.
///
/// Represents a single message sent by a user, containing text content
/// and metadata like delivery [status] and [time].
@HiveType(typeId: 2)
class Message {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String chatId;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final String senderId;

  @HiveField(4)
  final DateTime time;

  @HiveField(5)
  final MessageStatus status;

  Message({
    required this.id,
    required this.chatId,
    required this.text,
    required this.senderId,
    required this.time,
    this.status = MessageStatus.sent,
  });

  Message copyWith({
    String? id,
    String? chatId,
    String? text,
    String? senderId,
    DateTime? time,
    MessageStatus? status,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }
}
