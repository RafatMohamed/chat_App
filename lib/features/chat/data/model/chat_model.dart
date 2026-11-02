import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final List<String> participants;
  final String type;
  final String lastMessage;
  final DateTime lastMessageAt;
  final DateTime createdAt;

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.type,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'],
      participants: List<String>.from(json['participants']),
      type: json['type'],
      lastMessage: json['lastMessage'],
      lastMessageAt: (json['lastMessageAt'] as Timestamp).toDate(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'participants': participants,
      'type': type,
      'lastMessage': lastMessage,
      'lastMessageAt': Timestamp.fromDate(lastMessageAt),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
