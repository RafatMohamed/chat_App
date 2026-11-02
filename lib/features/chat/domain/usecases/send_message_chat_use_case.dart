import '../repo/chat_repo.dart';

class SendMessageChatUseCase {
  final ChatRepo _chatRepo;

  SendMessageChatUseCase({required this._chatRepo});

  Future<void> call({
    required String sendId,
    required String receiveId,
    required String message,
  }) {
    return _chatRepo.sendMessage(
      sendId: sendId,
      receiveId: receiveId,
      message: message,
    );
  }
}
