import 'package:scholar_chat_proj/features/chat/domain/entities/chat_entities.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/message_entities.dart';

abstract class ChatRepo {
  Stream<List<ChatEntity>> getChatStream({required String uid});

  Future<void> sendMessage({
    required String sendId,
    required String receiveId,
    required String message,
  });

  Stream<List<MessageEntity>> getMessagesStream(String chatId);
}
