part of 'get_users_cubit.dart';

@immutable
sealed class GetUsersState {}

final class GetUsersInitial extends GetUsersState {}

final class GetUsersLoading extends GetUsersState {}

final class GetUsersLoaded extends GetUsersState {
  final List<UserEntity> users;

  GetUsersLoaded({required this.users});
}

final class GetUsersFailed extends GetUsersState {
  final String error;

  GetUsersFailed(this.error);
}
