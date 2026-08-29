import 'package:ripple/models/chat.dart';

/// Abstraction over the current user's list of chats
abstract class ChatRepository {
  /// Returns whatever chats already available in memory
  /// without waiting for a network round-trip. Empty list if nothing cached yet
  List<Chat> getCachedChats();

  /// Returns a stream of the current user's chats
  ///
  /// The stream emits a new list whenever a chat is added or removed
  Stream<List<Chat>> getChats();

  /// Release resources held by the repository
  void dispose();
}