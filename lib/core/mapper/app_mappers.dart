import 'package:scholar_chat_proj/features/auth/data/models/users_model.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';
import 'package:scholar_chat_proj/features/chat/data/model/chat_model.dart';
import 'package:scholar_chat_proj/features/chat/data/model/message_model.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_entities.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/message_entities.dart';

class AppMappers {
  static UserEntity toUserEntity(UserModel user) {
    return UserEntity(
      uid: user.uid,
      username: user.username,
      email: user.email,
      phoneNumber: user.phoneNumber,
      bio: user.bio,
      isOnline: user.isOnline,
      lastSeen: user.lastSeen,
    );
  }

  static ChatEntity toChatEntity(ChatModel chat) {
    return ChatEntity(
      lastMessage: chat.lastMessage,
      chatId: chat.chatId,
      participants: chat.participants,
      type: chat.type,
      lastMessageAt: chat.lastMessageAt,
      createdAt: chat.createdAt,
    );
  }

  static MessageEntity toMessageEntity(MessageModel message) {
    return MessageEntity(
      messageId: message.messageId,
      senderId: message.senderId,
      text: message.text,
      createdAt: message.createdAt,
    );
  }
}
