import 'package:dart_either/dart_either.dart';

import '../../../auth/domain/entities/user_entities.dart';
import '../repo/user_repo.dart';

class GetUserStreamUseCase {
  final UserRepo _userRepo;

  GetUserStreamUseCase({required this._userRepo});

  Stream<Either<String, UserEntity>> call({required String userID}) {
    return _userRepo.getUserStream(userID);
  }
}
