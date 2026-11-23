import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String groupId;
  final String name;
  final List<String> members;
  final String createdBy;
  final String lastMessage;
  final DateTime lastMessageAt;
  final DateTime createdAt;

  GroupModel({
    required this.groupId,
    required this.name,
    required this.members,
    required this.createdBy,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.createdAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      groupId: json['groupId'],
      name: json['name'],
      members: List<String>.from(json['members']),
      createdBy: json['createdBy'],
      lastMessage: json['lastMessage'],
      lastMessageAt: (json['lastMessageAt'] as Timestamp).toDate(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'name': name,
      'members': members,
      'createdBy': createdBy,
      'lastMessage': lastMessage,
      'lastMessageAt': Timestamp.fromDate(lastMessageAt),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
