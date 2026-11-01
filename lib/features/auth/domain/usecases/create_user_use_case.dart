import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/user_repo.dart';

import '../entities/user_entities.dart';

class CreateUserUseCase {
  final UserRepo _userRepo;

  CreateUserUseCase({required this._userRepo});

  Future<Either<String, UserEntity>> call({
    required UserEntity user,
    required String uid,
  }) async {
    return await _userRepo.createUser(user: user, uid: uid);
  }
}
