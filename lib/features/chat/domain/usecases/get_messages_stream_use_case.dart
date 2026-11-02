import '../entities/message_entities.dart';
import '../repo/chat_repo.dart';

class GetMessagesStreamUseCase {
  final ChatRepo _chatRepo;

  GetMessagesStreamUseCase({required this._chatRepo});

  Stream<List<MessageEntity>> call(String chatId) {
    return _chatRepo.getMessagesStream(chatId);
  }
}
