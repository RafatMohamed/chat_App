import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import 'package:scholar_chat_proj/features/groups/domain/entities/group_entities.dart';
import 'package:scholar_chat_proj/features/groups/domain/usecases/get_groups_stream_use_case.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit({
    required this._getGroupsStreamUseCase,
    required this._userIDUseCase,
  }) : super(GroupInitial());

  final GetGroupsStreamUseCase _getGroupsStreamUseCase;
  final GetUserIDUseCase _userIDUseCase;

  StreamSubscription<List<GroupEntity>>? _groupsSubscription;

  Future<void> getGroupsStream() async {
    final userID = _userIDUseCase();

    if (userID == null) {
      emit(GroupFailed(message: 'User not authenticated'));
      return;
    }

    emit(GroupLoading());

    await _groupsSubscription?.cancel();

    _groupsSubscription = _getGroupsStreamUseCase
        .call(userID: userID)
        .listen(
          (groups) {
            if (isClosed) return;
            emit(GroupLoaded(groups: groups));
          },
          onError: (error, stackTrace) {
            log('GROUPS STREAM ERROR: $error');
            if (!isClosed) {
              emit(GroupFailed(message: error.toString()));
            }
          },
        );
  }

  @override
  Future<void> close() async {
    await _groupsSubscription?.cancel();
    return super.close();
  }
}
