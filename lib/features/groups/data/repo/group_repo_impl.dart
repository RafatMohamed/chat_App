import 'package:scholar_chat_proj/core/mapper/app_mappers.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/message_entities.dart';
import 'package:scholar_chat_proj/features/groups/domain/entities/group_entities.dart';

import '../../domain/repo/group_repo.dart';
import '../datasources/remot_data_source/group_remote_data_source.dart';

class GroupRepoImpl implements GroupRepo {
  final GroupRemoteDataSource _groupRemoteDataSource;

  GroupRepoImpl({required this._groupRemoteDataSource});

  @override
  Future<GroupEntity> createGroup({
    required String name,
    required String createdBy,
    required List<String> members,
  }) async {
    final group = await _groupRemoteDataSource.createGroup(
      name: name,
      createdBy: createdBy,
      members: members,
    );
    return AppMappers.toGroupEntity(group);
  }

  @override
  Stream<List<GroupEntity>> getGroupsStream({required String uid}) {
    return _groupRemoteDataSource.getGroupsStream(uid).map((groups) {
      return groups.map((group) => AppMappers.toGroupEntity(group)).toList();
    });
  }

  @override
  Future<void> sendGroupMessage({
    required String groupId,
    required String sendId,
    required String message,
  }) {
    return _groupRemoteDataSource.sendGroupMessage(
      groupId: groupId,
      sendId: sendId,
      message: message,
    );
  }

  @override
  Stream<List<MessageEntity>> getGroupMessagesStream(String groupId) {
    return _groupRemoteDataSource.getGroupMessagesStream(groupId).map((
      messages,
    ) {
      return messages
          .map((message) => AppMappers.toMessageEntity(message))
          .toList();
    });
  }
}
