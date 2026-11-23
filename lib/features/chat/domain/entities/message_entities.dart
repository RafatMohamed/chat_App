class MessageEntity {
  final String messageId;
  final String senderId;
  final String? senderName;
  final String text;
  final DateTime createdAt;

  MessageEntity({
    required this.messageId,
    required this.senderId,
    this.senderName,
    required this.text,
    required this.createdAt,
  });
}
