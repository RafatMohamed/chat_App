part of 'create_group_cubit.dart';

@immutable
sealed class CreateGroupState {}

final class CreateGroupInitial extends CreateGroupState {}

final class CreateGroupLoading extends CreateGroupState {}

final class CreateGroupSuccess extends CreateGroupState {
  final GroupEntity group;

  CreateGroupSuccess({required this.group});
}

final class CreateGroupFailure extends CreateGroupState {
  final String message;

  CreateGroupFailure({required this.message});
}
