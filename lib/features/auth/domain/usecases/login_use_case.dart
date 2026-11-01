import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/auth_repo.dart';

import '../entities/user_entities.dart';

class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase({required this._authRepo});

  Future<Either<String, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await _authRepo.login(email, password);
  }
}
