part of 'group_cubit.dart';

@immutable
sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupLoading extends GroupState {}

final class GroupLoaded extends GroupState {
  final List<GroupEntity> groups;

  GroupLoaded({required this.groups});
}

final class GroupFailed extends GroupState {
  final String message;

  GroupFailed({required this.message});
}
