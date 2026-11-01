import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  const AuthSuccess(this.user);

  final UserEntity user;
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;
}

class AuthPasswordResetSent extends AuthState {
  const AuthPasswordResetSent();
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}
