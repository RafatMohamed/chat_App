import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_chat_proj/core/mapper/app_mappers.dart';
import 'package:scholar_chat_proj/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/error/auth_exeptions.dart';
import '../../domain/entities/user_entities.dart';
import '../datasources/remot_data_source/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl({required this._authRemoteDataSource});

  @override
  Future<Either<String, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      var resultLogin = await _authRemoteDataSource.login(email, password);
      return Right(AppMappers.toUserEntity(resultLogin));
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(getAuthErrorMessage(e.code));
      }
      return const Left("Something went wrong");
    }
  }

  @override
  Future<Either<String, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      var resultRegister = await _authRemoteDataSource.register(
        email: email,
        password: password,
        userName: name,
        phoneNumber: phone,
      );
      return Right(AppMappers.toUserEntity(resultRegister));
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(getAuthErrorMessage(e.code));
      }
      return const Left("Something went wrong");
    }
  }

  @override
  Future<Either<String, void>> forgotPassword(String email) async {
    try {
      await _authRemoteDataSource.forgotPassword(email);
      return const Right(null);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(getAuthErrorMessage(e.code));
      }
      return const Left("Something went wrong");
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      await _authRemoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(getAuthErrorMessage(e.code));
      }
      return const Left("Something went wrong");
    }
  }

  @override
  String? getCurrentUserID() {
    return _authRemoteDataSource.getCurrentUserID();
  }
}
