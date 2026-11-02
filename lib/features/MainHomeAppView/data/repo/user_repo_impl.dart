import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/core/mapper/app_mappers.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/repo/user_repo.dart';
import 'package:scholar_chat_proj/features/auth/data/models/users_model.dart';

import '../../../auth/domain/entities/user_entities.dart';
import '../datasources/remot_data_source/user_remote_data_source.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepoImpl({required this._userRemoteDataSource});

  @override
  Future<Either<String, UserEntity>> createUser({
    required UserEntity user,
    required String uid,
  }) async {
    try {
      UserModel userModel = UserModel(
        uid: uid,
        username: user.username,
        email: user.email,
        createdAt: DateTime.now(),
        isOnline: user.isOnline,
        lastSeen: user.lastSeen,
        phoneNumber: user.phoneNumber,
      );
      var result = await _userRemoteDataSource.createUser(userModel);
      return Right(AppMappers.toUserEntity(result));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<Either<String, UserEntity>> getUserStream(String uid) {
    return _userRemoteDataSource
        .getUserStream(uid)
        .map<Either<String, UserEntity>>((userModel) {
          final user = AppMappers.toUserEntity(userModel);
          return Right<String, UserEntity>(user);
        })
        .transform(
          StreamTransformer.fromHandlers(
            handleError: (error, stackTrace, sink) {
              sink.add(Left<String, UserEntity>(error.toString()));
            },
          ),
        );
  }

  @override
  Future<Either<String, UserEntity>> getUser(String uid) async {
    try {
      final result = await _userRemoteDataSource.getUser(uid);
      return Right(AppMappers.toUserEntity(result));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> updateUser({
    required UserEntity user,
    required String uid,
  }) async {
    try {
      UserModel userModel = UserModel(
        uid: uid,
        username: user.username,
        email: user.email,
        createdAt: DateTime.now(),
        isOnline: user.isOnline,
        lastSeen: user.lastSeen,
        phoneNumber: user.phoneNumber,
      );
      await _userRemoteDataSource.updateUser(userModel);
      return Right(AppMappers.toUserEntity(userModel));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> deleteUser(String uid) async {
    await _userRemoteDataSource.deleteUser(uid);
  }

  @override
  Future<Either<String, List<UserEntity>>> getUsers() async {
    try {
      final user = await _userRemoteDataSource.getUsers();
      final result = user.map((e) {
        return AppMappers.toUserEntity(e);
      }).toList();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<UserEntity>>> getUsersFiltered(
    String query,
  ) async {
    try {
      final user = await _userRemoteDataSource.getUsersFiltered(query);
      final result = user.map((e) {
        return AppMappers.toUserEntity(e);
      }).toList();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
