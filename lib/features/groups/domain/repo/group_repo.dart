import 'package:scholar_chat_proj/features/chat/domain/entities/message_entities.dart';
import 'package:scholar_chat_proj/features/groups/domain/entities/group_entities.dart';

abstract class GroupRepo {
  Future<GroupEntity> createGroup({
    required String name,
    required String createdBy,
    required List<String> members,
  });

  Stream<List<GroupEntity>> getGroupsStream({required String uid});

  Future<void> sendGroupMessage({
    required String groupId,
    required String sendId,
    required String message,
  });

  Stream<List<MessageEntity>> getGroupMessagesStream(String groupId);
}
