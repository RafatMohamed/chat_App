import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/user_repo.dart';

import '../../../auth/domain/entities/user_entities.dart';

class GetUserStreamUseCase {
  final UserRepo _userRepo;

  GetUserStreamUseCase({required this._userRepo});

  Stream<Either<String, UserEntity>> call({required String userID}) {
    return _userRepo.getUserStream(userID);
  }
}
