import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/auth/domain/usecases/logout_use_case.dart';

import '../../../MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import '../../domain/usecases/reset_password_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this._registerUseCase,
    required this._loginUseCase,
    required this._logoutUseCase,
    required this._resetPasswordUseCase,
    required this.userIDUseCase,
  }) : super(const AuthInitial());

  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final LogOutUseCase _logoutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final GetUserIDUseCase userIDUseCase;

  Future<void> register({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  }) async {
    emit(const AuthLoading());

    final authResult = await _registerUseCase(
      email: email,
      password: password,
      name: username,
      phone: phoneNumber,
    );

    authResult.fold(
      ifLeft: (code) => emit(AuthFailure(code)),
      ifRight: (authUser) => emit(AuthSuccess(authUser)),
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    final result = await _loginUseCase(email: email, password: password);
    result.fold(
      ifLeft: (code) => emit(AuthFailure(code)),
      ifRight: (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> logout() async {
    final result = await _logoutUseCase();
    result.fold(
      ifLeft: (code) => emit(AuthFailure(code)),
      ifRight: (_) => emit(const AuthLoggedOut()),
    );
  }

  Future<void> resetPassword(String email) async {
    emit(const AuthLoading());
    final result = await _resetPasswordUseCase(email: email);
    result.fold(
      ifLeft: (code) => emit(AuthFailure(code)),
      ifRight: (_) => emit(const AuthPasswordResetSent()),
    );
  }

  String? getCurrentUserID() {
    return userIDUseCase();
  }
}
