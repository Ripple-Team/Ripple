import 'package:messenger/models/message.dart';

abstract class MessageRepository {
  Stream<List<Message>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, String text);
  void dispose();
}