import '../entities/group_entities.dart';
import '../repo/group_repo.dart';

class GetGroupsStreamUseCase {
  final GroupRepo _groupRepo;

  GetGroupsStreamUseCase({required this._groupRepo});

  Stream<List<GroupEntity>> call({required String userID}) {
    return _groupRepo.getGroupsStream(uid: userID);
  }
}
