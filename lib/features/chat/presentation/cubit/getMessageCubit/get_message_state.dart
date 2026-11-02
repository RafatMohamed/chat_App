import '../../../domain/entities/message_entities.dart';

sealed class GetMessagesState {}

final class MessagesInitial extends GetMessagesState {}

final class MessagesLoading extends GetMessagesState {}

final class MessagesLoaded extends GetMessagesState {
  final List<MessageEntity> messages;

  MessagesLoaded({required this.messages});
}

final class MessagesFailure extends GetMessagesState {
  final String message;

  MessagesFailure({required this.message});
}
