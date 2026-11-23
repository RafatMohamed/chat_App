import '../repo/group_repo.dart';

class SendGroupMessageUseCase {
  final GroupRepo _groupRepo;

  SendGroupMessageUseCase({required this._groupRepo});

  Future<void> call({
    required String groupId,
    required String sendId,
    required String message,
  }) {
    return _groupRepo.sendGroupMessage(
      groupId: groupId,
      sendId: sendId,
      message: message,
    );
  }
}
