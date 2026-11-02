import 'package:scholar_chat_proj/features/chat/domain/entities/chat_entities.dart';

import '../repo/chat_repo.dart';

class GetChatStreamUseCase {
  final ChatRepo _chatRepo;

  GetChatStreamUseCase({required this._chatRepo});

  Stream<List<ChatEntity>> call({required String userID}) {
    return _chatRepo.getChatStream(uid: userID);
  }
}
