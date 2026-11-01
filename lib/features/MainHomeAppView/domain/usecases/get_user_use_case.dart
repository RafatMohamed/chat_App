import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/user_repo.dart';

import '../../../auth/domain/entities/user_entities.dart';

class GetUserUseCase {
  final UserRepo _userRepo;

  GetUserUseCase({required this._userRepo});

  Future<Either<String, UserEntity>> call({required String userID}) async {
    return await _userRepo.getUser(userID);
  }
}
