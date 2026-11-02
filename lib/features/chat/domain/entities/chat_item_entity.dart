import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_entities.dart';

class ChatItemEntity {
  final ChatEntity chat;
  final UserEntity otherUser;

  ChatItemEntity({required this.chat, required this.otherUser});
}
