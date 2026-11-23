class GroupEntity {
  final String groupId;
  final String name;
  final List<String> members;
  final String createdBy;
  final String lastMessage;
  final DateTime lastMessageAt;
  final DateTime createdAt;

  GroupEntity({
    required this.groupId,
    required this.name,
    required this.members,
    required this.createdBy,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.createdAt,
  });
}
