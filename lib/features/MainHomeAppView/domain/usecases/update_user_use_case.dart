import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/user_repo.dart';

import '../../../auth/domain/entities/user_entities.dart';

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
