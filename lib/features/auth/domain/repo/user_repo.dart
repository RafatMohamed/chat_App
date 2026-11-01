import 'package:dart_either/dart_either.dart';

import '../entities/user_entities.dart';

abstract class UserRepo {
  Future<Either<String, UserEntity>> createUser({
    required UserEntity user,
    required String uid,
  });

  Future<Either<String, UserEntity>> getUser(String uid);

  Stream<Either<String, UserEntity>> getUserStream(String uid);

  Future<Either<String, List<UserEntity>>> getUsers();

  Future<Either<String, List<UserEntity>>> getUsersFiltered(String query);

  Future<Either<String, UserEntity>> updateUser({
    required UserEntity user,
    required String uid,
  });

  Future<void> deleteUser(String uid);
}
