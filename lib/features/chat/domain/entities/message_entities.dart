class MessageEntity {
  final String messageId;
  final String senderId;
  final String text;
  final DateTime createdAt;

  MessageEntity({
    required this.messageId,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });
}
