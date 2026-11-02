import 'package:scholar_chat_proj/features/MainHomeAppView/domain/repo/user_repo.dart';

class UpdateLastSeenUseCase {
  final UserRepo _userRepo;

  UpdateLastSeenUseCase({required this._userRepo});

  Future<void> call({required String userID}) async {
    return await _userRepo.updateLastSeen(userID);
  }
}
