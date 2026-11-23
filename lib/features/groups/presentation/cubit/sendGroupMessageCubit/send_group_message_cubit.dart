import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/usecases/get_user_stream_use_case.dart';
import 'package:scholar_chat_proj/features/groups/domain/usecases/send_group_message_use_case.dart';

part 'send_group_message_state.dart';

class SendGroupMessageCubit extends Cubit<SendGroupMessageState> {
  SendGroupMessageCubit({
    required this._sendGroupMessageUseCase,
    required this._userIDUseCase,
    required this._getUserStreamUseCase,
  }) : super(SendGroupMessageInitial());

  final SendGroupMessageUseCase _sendGroupMessageUseCase;
  final GetUserIDUseCase _userIDUseCase;
  final GetUserStreamUseCase _getUserStreamUseCase;

  String? _senderNameCache;

  Future<String> _resolveSenderName(String sendId) async {
    if (_senderNameCache != null) return _senderNameCache!;

    final result = await _getUserStreamUseCase(userID: sendId).first;

    return result.fold(
      ifLeft: (error) {
        log('SENDER NAME ERROR: $error');
        return '';
      },
      ifRight: (user) {
        _senderNameCache = user.username;
        return user.username;
      },
    );
  }

  Future<void> sendGroupMessage({
    required String groupId,
    required String message,
  }) async {
    final sendId = _userIDUseCase();

    if (sendId == null) {
      emit(SendGroupMessageFailure(message: 'User not authenticated'));
      log('User not authenticated');
      return;
    }

    if (message.trim().isEmpty) return;

    emit(SendGroupMessageLoading());

    try {
      final senderName = await _resolveSenderName(sendId);

      await _sendGroupMessageUseCase.call(
        groupId: groupId,
        sendId: sendId,
        senderName: senderName,
        message: message.trim(),
      );

      emit(SendGroupMessageSuccess());
    } catch (e) {
      log(e.toString());
      emit(SendGroupMessageFailure(message: e.toString()));
    }
  }
}
