import 'package:dart_either/dart_either.dart';

import '../../../auth/domain/entities/user_entities.dart';
import '../repo/user_repo.dart';

class UpdateUserUseCase {
  final UserRepo _userRepo;

  UpdateUserUseCase({required this._userRepo});

  Future<Either<String, UserEntity>> call({
    required UserEntity user,
    required String uid,
  }) async {
    return await _userRepo.updateUser(user: user, uid: uid);
  }
}
