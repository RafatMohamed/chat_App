part of 'update_user_cubit.dart';

@immutable
sealed class UpdateUserState {}

final class UpdateUserInitial extends UpdateUserState {}

final class UpdateUserLoading extends UpdateUserState {}

final class UpdateUserSuccess extends UpdateUserState {
  final UserEntity user;

  UpdateUserSuccess({required this.user});
}

final class UpdateUserError extends UpdateUserState {
  final String message;

  UpdateUserError(this.message);
}
