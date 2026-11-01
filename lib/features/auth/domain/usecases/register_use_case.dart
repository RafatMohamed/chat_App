import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/auth_repo.dart';

import '../entities/user_entities.dart';

class RegisterUseCase {
  final AuthRepo _authRepo;

  const RegisterUseCase({required this._authRepo});

  Future<Either<String, UserEntity>> call({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    return await _authRepo.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }
}
