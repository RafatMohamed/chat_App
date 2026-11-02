import 'dart:async';
import 'dart:developer';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_entities.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_item_entity.dart';
import 'package:scholar_chat_proj/features/chat/domain/usecases/get_chat_stream_use_case.dart';

import '../../../../MainHomeAppView/domain/usecases/get_user_stream_use_case.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this._getChatStreamUseCase,
    required this._userIDUseCase,
    required this._getUserStreamUseCase,
  }) : super(ChatInitial());

  final GetChatStreamUseCase _getChatStreamUseCase;
  final GetUserIDUseCase _userIDUseCase;
  final GetUserStreamUseCase _getUserStreamUseCase;

  StreamSubscription<List<ChatEntity>>? _chatSubscription;

  final Map<String, StreamSubscription<Either<String, UserEntity>>>
  _userSubscriptions = {};

  final Map<String, UserEntity> _usersCache = {};

  List<ChatEntity> _latestChats = [];

  String? _currentUserId;

  Future<void> getChatStream() async {
    final userID = _userIDUseCase();

    if (userID == null) {
      emit(ChatFailed(message: 'User not authenticated'));
      return;
    }

    _currentUserId = userID;

    emit(ChatLoading());

    await _chatSubscription?.cancel();

    _chatSubscription = _getChatStreamUseCase
        .call(userID: userID)
        .listen(
          (chats) {
            if (isClosed) return;

            _latestChats = chats;

            final activeUserIds = <String>{};

            for (final chat in chats) {
              final otherUserIds = chat.participants
                  .where((id) => id != userID)
                  .toList();

              if (otherUserIds.isEmpty) {
                log('Invalid chat: ${chat.chatId}');
                continue;
              }

              final otherUserId = otherUserIds.first;

              activeUserIds.add(otherUserId);
              _listenToOtherUser(otherUserId);
            }

            _removeInactiveUserSubscriptions(activeUserIds);

            _emitChatLoaded();
          },
          onError: (error, stackTrace) {
            log('CHAT STREAM ERROR: $error');
            if (!isClosed) {
              emit(ChatFailed(message: error.toString()));
            }
          },
        );
  }

  void _listenToOtherUser(String otherUserId) {
    if (_userSubscriptions.containsKey(otherUserId)) return;

    final subscription = _getUserStreamUseCase(userID: otherUserId).listen(
      (result) {
        if (isClosed) return;

        result.fold(
          ifLeft: (error) {
            log('USER STREAM ERROR ($otherUserId): $error');
          },
          ifRight: (user) {
            _usersCache[otherUserId] = user;
            _emitChatLoaded();
          },
        );
      },
      onError: (error) {
        log('USER STREAM FAILED ($otherUserId): $error');
      },
    );

    _userSubscriptions[otherUserId] = subscription;
  }

  void _emitChatLoaded() {
    if (isClosed || _currentUserId == null) return;

    final chatItems = <ChatItemEntity>[];

    for (final chat in _latestChats) {
      final otherUserIds = chat.participants
          .where((id) => id != _currentUserId)
          .toList();

      if (otherUserIds.isEmpty) continue;

      final otherUser = _usersCache[otherUserIds.first];

      if (otherUser == null) continue;

      chatItems.add(ChatItemEntity(chat: chat, otherUser: otherUser));
    }

    emit(ChatLoaded(chats: chatItems));
  }

  Future<void> _removeInactiveUserSubscriptions(
    Set<String> activeUserIds,
  ) async {
    final inactiveUserIds = _userSubscriptions.keys
        .where((id) => !activeUserIds.contains(id))
        .toList();

    for (final userId in inactiveUserIds) {
      await _userSubscriptions.remove(userId)?.cancel();
      _usersCache.remove(userId);
    }
  }

  @override
  Future<void> close() async {
    await _chatSubscription?.cancel();

    for (final subscription in _userSubscriptions.values) {
      await subscription.cancel();
    }

    _userSubscriptions.clear();

    return super.close();
  }
}
