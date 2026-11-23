import '../../../chat/domain/entities/message_entities.dart';
import '../repo/group_repo.dart';

class GetGroupMessagesStreamUseCase {
  final GroupRepo _groupRepo;

  GetGroupMessagesStreamUseCase({required this._groupRepo});

  Stream<List<MessageEntity>> call(String groupId) {
    return _groupRepo.getGroupMessagesStream(groupId);
  }
}
