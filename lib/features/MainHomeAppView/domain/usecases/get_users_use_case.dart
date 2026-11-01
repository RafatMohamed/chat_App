import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/user_repo.dart';

import '../../../auth/domain/entities/user_entities.dart';

class GetUsersUseCase {
  final UserRepo _userRepo;

  GetUsersUseCase({required this._userRepo});

  Future<Either<String, List<UserEntity>>> call() async {
    return await _userRepo.getUsers();
  }
}
