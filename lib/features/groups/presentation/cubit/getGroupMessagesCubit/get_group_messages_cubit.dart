import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/message_entities.dart';

import '../../../../MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import '../../../domain/usecases/get_group_messages_stream_use_case.dart';
import 'get_group_messages_state.dart';

class GetGroupMessagesCubit extends Cubit<GetGroupMessagesState> {
  GetGroupMessagesCubit({
    required this._getGroupMessagesStreamUseCase,
    required this._getUserIdUseCase,
  }) : super(GroupMessagesInitial());

  List<MessageEntity> messages = [];

  final GetGroupMessagesStreamUseCase _getGroupMessagesStreamUseCase;

  StreamSubscription<List<MessageEntity>>? _messagesSubscription;

  final GetUserIDUseCase _getUserIdUseCase;

  String? get currentUserId => _getUserIdUseCase();

  void getMessages({required String groupId}) {
    emit(GroupMessagesLoading());

    _messagesSubscription?.cancel();

    _messagesSubscription = _getGroupMessagesStreamUseCase
        .call(groupId)
        .listen(
          (messages) {
            this.messages = messages;
            emit(GroupMessagesLoaded(messages: messages));
          },
          onError: (error) {
            messages = [];
            log(error.toString());
            emit(GroupMessagesFailure(message: error.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
