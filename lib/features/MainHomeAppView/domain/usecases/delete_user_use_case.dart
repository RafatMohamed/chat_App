import 'package:scholar_chat_proj/features/MainHomeAppView/domain/repo/user_repo.dart';

class DeleteUserUseCase {
  final UserRepo _userRepo;

  DeleteUserUseCase({required this._userRepo});

  Future<void> call({required String userID}) async {
    return await _userRepo.deleteUser(userID);
  }
}
