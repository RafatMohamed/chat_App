import 'package:dart_either/dart_either.dart';

import '../../../auth/domain/entities/user_entities.dart';
import '../repo/user_repo.dart';

class GetUsersUseCase {
  final UserRepo _userRepo;

  GetUsersUseCase({required this._userRepo});

  Future<Either<String, List<UserEntity>>> call() async {
    return await _userRepo.getUsers();
  }
}
