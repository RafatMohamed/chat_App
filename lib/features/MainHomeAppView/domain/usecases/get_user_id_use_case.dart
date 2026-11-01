import '../../../auth/domain/repo/auth_repo.dart';

class GetUserIDUseCase {
  final AuthRepo _authRepo;

  GetUserIDUseCase({required this._authRepo});

  String? call() {
    return _authRepo.getCurrentUserID();
  }
}
