import 'package:dart_either/dart_either.dart';

import '../../../auth/domain/entities/user_entities.dart';
import '../repo/user_repo.dart';

class GetUserUseCase {
  final UserRepo _userRepo;

  GetUserUseCase({required this._userRepo});

  Future<Either<String, UserEntity>> call({required String userID}) async {
    return await _userRepo.getUser(userID);
  }
}
