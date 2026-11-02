import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_entities.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_item_entity.dart';
import 'package:scholar_chat_proj/features/chat/domain/usecases/get_chat_stream_use_case.dart';

import '../../../../MainHomeAppView/domain/usecases/get_user_use_case.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this._getChatStreamUseCase,
    required this._userIDUseCase,
    required this._getUserUseCase,
  }) : super(ChatInitial());

  final GetChatStreamUseCase _getChatStreamUseCase;
  final GetUserIDUseCase _userIDUseCase;
  final GetUserUseCase _getUserUseCase;

  StreamSubscription<List<ChatEntity>>? _chatSubscription;

  final Map<String, UserEntity> _usersCache = {};

  Future<void> getChatStream() async {
    final userID = _userIDUseCase();

    if (userID == null) {
      emit(ChatFailed(message: 'User not authenticated'));
      return;
    }

    emit(ChatLoading());

    await _chatSubscription?.cancel();

    _chatSubscription = _getChatStreamUseCase
        .call(userID: userID)
        .listen(
          (chats) async {
            try {
              final chatItems = await Future.wait(
                chats.map((chat) async {
                  final otherUserIds = chat.participants
                      .where((id) => id != userID)
                      .toList();

                  if (otherUserIds.isEmpty) {
                    log('Invalid chat participants: ${chat.participants}');
                  }

                  final otherUserId = otherUserIds.first;

                  UserEntity? otherUser = _usersCache[otherUserId];

                  if (otherUser == null) {
                    final result = await _getUserUseCase.call(
                      userID: otherUserId,
                    );

                    result.fold(
                      ifLeft: (error) {},
                      ifRight: (user) {
                        otherUser = user;
                        _usersCache[otherUserId] = user;
                      },
                    );
                  }

                  if (otherUser == null) return null;

                  return ChatItemEntity(chat: chat, otherUser: otherUser!);
                }),
              );

              if (isClosed) return;

              emit(
                ChatLoaded(
                  chats: chatItems.whereType<ChatItemEntity>().toList(),
                ),
              );
            } catch (e) {
              if (!isClosed) {
                emit(ChatFailed(message: e.toString()));
              }
            }
          },
          onError: (error, stackTrace) {
            debugPrint('CHAT STREAM ERROR: $error');
            debugPrint('STACK TRACE: $stackTrace');

            if (!isClosed) {
              emit(ChatFailed(message: error.toString()));
            }
          },
        );
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
