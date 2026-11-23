import '../entities/group_entities.dart';
import '../repo/group_repo.dart';

class CreateGroupUseCase {
  final GroupRepo _groupRepo;

  CreateGroupUseCase({required this._groupRepo});

  Future<GroupEntity> call({
    required String name,
    required String createdBy,
    required List<String> members,
  }) {
    return _groupRepo.createGroup(
      name: name,
      createdBy: createdBy,
      members: members,
    );
  }
}
