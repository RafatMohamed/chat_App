part of 'get_current_user_cubit.dart';

@immutable
sealed class GetCurrentUserState {}

final class GetCurrentUserInitial extends GetCurrentUserState {}

final class GetCurrentUserLoading extends GetCurrentUserState {}

final class GetCurrentUserSuccess extends GetCurrentUserState {
  final UserEntity user;

  GetCurrentUserSuccess(this.user);
}

final class GetCurrentUserFailure extends GetCurrentUserState {
  final String message;

  GetCurrentUserFailure(this.message);
}
