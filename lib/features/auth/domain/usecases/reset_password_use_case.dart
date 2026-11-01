import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/auth_repo.dart';

class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase({required this._authRepo});

  Future<Either<String, void>> call({required String email}) async {
    return await _authRepo.forgotPassword(email);
  }
}
