import '../../../../chat/domain/entities/message_entities.dart';

sealed class GetGroupMessagesState {}

final class GroupMessagesInitial extends GetGroupMessagesState {}

final class GroupMessagesLoading extends GetGroupMessagesState {}

final class GroupMessagesLoaded extends GetGroupMessagesState {
  final List<MessageEntity> messages;

  GroupMessagesLoaded({required this.messages});
}

final class GroupMessagesFailure extends GetGroupMessagesState {
  final String message;

  GroupMessagesFailure({required this.message});
}
