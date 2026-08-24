import 'package:messenger/utils/message_utils.dart';

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
    );
  }
}
