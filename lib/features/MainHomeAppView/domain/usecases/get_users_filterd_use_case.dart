import 'package:dart_either/dart_either.dart';

import '../../../auth/domain/entities/user_entities.dart';
import '../repo/user_repo.dart';

class GetUsersFilterUseCase {
  final UserRepo _userRepo;

  GetUsersFilterUseCase({required this._userRepo});

  Future<Either<String, List<UserEntity>>> call({required String query}) async {
    return await _userRepo.getUsersFiltered(query);
  }
}
