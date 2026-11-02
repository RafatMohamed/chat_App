import 'dart:async';

import 'package:scholar_chat_proj/core/mapper/app_mappers.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_entities.dart';

import '../../domain/entities/message_entities.dart';
import '../../domain/repo/chat_repo.dart';
import '../datasources/remot_data_source/chat_remote_data_source.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatRemoteDataSource _chatRemoteDataSource;

  ChatRepoImpl({required this._chatRemoteDataSource});

  @override
  Stream<List<ChatEntity>> getChatStream({required String uid}) {
    return _chatRemoteDataSource.getRecentChatsStream(uid).map((chats) {
      return chats.map((chat) => AppMappers.toChatEntity(chat)).toList();
    });
  }

  @override
  Future<void> sendMessage({
    required String sendId,
    required String receiveId,
    required String message,
  }) {
    return _chatRemoteDataSource.sendMessage(
      sendId: sendId,
      receiveId: receiveId,
      message: message,
    );
  }

  @override
  Stream<List<MessageEntity>> getMessagesStream(String chatId) {
    return _chatRemoteDataSource.getMessagesStream(chatId).map((messages) {
      return messages
          .map((message) => AppMappers.toMessageEntity(message))
          .toList();
    });
  }
}
