import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import 'package:scholar_chat_proj/features/groups/domain/entities/group_entities.dart';
import 'package:scholar_chat_proj/features/groups/domain/usecases/create_group_use_case.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit({
    required this._createGroupUseCase,
    required this._userIDUseCase,
  }) : super(CreateGroupInitial());

  final CreateGroupUseCase _createGroupUseCase;
  final GetUserIDUseCase _userIDUseCase;

  Future<void> createGroup({
    required String name,
    required List<String> members,
  }) async {
    final userID = _userIDUseCase();

    if (userID == null) {
      emit(CreateGroupFailure(message: 'User not authenticated'));
      log('User not authenticated');
      return;
    }

    if (name.trim().isEmpty) return;

    emit(CreateGroupLoading());

    try {
      final group = await _createGroupUseCase.call(
        name: name.trim(),
        createdBy: userID,
        members: members,
      );

      emit(CreateGroupSuccess(group: group));
    } catch (e) {
      log(e.toString());
      emit(CreateGroupFailure(message: e.toString()));
    }
  }
}
