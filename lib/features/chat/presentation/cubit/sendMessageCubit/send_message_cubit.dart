import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import 'package:scholar_chat_proj/features/chat/domain/usecases/send_message_chat_use_case.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({
    required this._sendMessageUseCase,
    required this._userIDUseCase,
  }) : super(SendMessageInitial());

  final SendMessageChatUseCase _sendMessageUseCase;
  final GetUserIDUseCase _userIDUseCase;

  Future<void> sendMessage({
    required String receiveId,
    required String message,
  }) async {
    final sendId = _userIDUseCase();

    if (sendId == null) {
      emit(SendMessageFailure(message: 'User not authenticated'));
      log('User not authenticated');
      return;
    }

    if (message.trim().isEmpty) return;

    emit(SendMessageLoading());

    try {
      await _sendMessageUseCase.call(
        sendId: sendId,
        receiveId: receiveId,
        message: message.trim(),
      );

      emit(SendMessageSuccess());
    } catch (e) {
      log(e.toString());
      emit(SendMessageFailure(message: e.toString()));
    }
  }
}
