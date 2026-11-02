class ChatEntity {
  final String chatId;
  final List<String> participants;
  final String type;
  final String lastMessage;
  final DateTime lastMessageAt;
  final DateTime createdAt;

  ChatEntity({
    required this.chatId,
    required this.participants,
    required this.type,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.createdAt,
  });
}
