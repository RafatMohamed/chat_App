import 'package:dart_either/dart_either.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';

abstract class AuthRepo {
  Future<Either<String, UserEntity>> login(String email, String password);

  Future<Either<String, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  Future<Either<String, void>> forgotPassword(String email);

  Future<Either<String, void>> logout();

  String? getCurrentUserID();
}
