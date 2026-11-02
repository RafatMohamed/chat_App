import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import '../../../domain/entities/message_entities.dart';
import '../../../domain/usecases/get_messages_stream_use_case.dart';
import 'get_message_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit({
    required this._getMessagesStreamUseCase,
    required this._getUserIdUseCase,
  }) : super(MessagesInitial());
  List<MessageEntity> messages = [];
  final GetMessagesStreamUseCase _getMessagesStreamUseCase;

  StreamSubscription<List<MessageEntity>>? _messagesSubscription;

  final GetUserIDUseCase _getUserIdUseCase;

  String? get currentUserId => _getUserIdUseCase();

  void getMessages({required String chatId}) {
    emit(MessagesLoading());

    _messagesSubscription?.cancel();

    _messagesSubscription = _getMessagesStreamUseCase
        .call(chatId)
        .listen(
          (messages) {
            this.messages = messages;
            emit(MessagesLoaded(messages: messages));
          },
          onError: (error) {
            messages = [];
            log(error.toString());
            emit(MessagesFailure(message: error.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
