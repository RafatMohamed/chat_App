part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<ChatItemEntity> chats;

  ChatLoaded({required this.chats});
}

final class ChatFailed extends ChatState {
  final String message;

  ChatFailed({required this.message});
}
