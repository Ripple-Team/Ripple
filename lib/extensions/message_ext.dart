import 'package:ripple/models/message.dart';

extension MessageX on Message {
  bool isMine(String currentUserId) => senderId == currentUserId;
}