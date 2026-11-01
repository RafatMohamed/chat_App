import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/auth_repo.dart';

class LogOutUseCase {
  final AuthRepo _authRepo;

  LogOutUseCase({required this._authRepo});

  Future<Either<String, void>> call() async {
    return await _authRepo.logout();
  }
}
