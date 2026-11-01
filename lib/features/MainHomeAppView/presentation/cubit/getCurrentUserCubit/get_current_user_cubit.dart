import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';

import '../../../domain/usecases/get_user_id_use_case.dart';
import '../../../domain/usecases/get_user_stream_use_case.dart';
import '../../../domain/usecases/get_user_use_case.dart';

part 'get_current_user_state.dart';

class GetCurrentUserCubit extends Cubit<GetCurrentUserState> {
  GetCurrentUserCubit({
    required this._getUserIDUseCase,
    required this._getCurrentUserUseCase,
    required this._getUserStreamUseCase,
  }) : super(GetCurrentUserInitial());

  final GetUserIDUseCase _getUserIDUseCase;
  final GetUserUseCase _getCurrentUserUseCase;
  final GetUserStreamUseCase _getUserStreamUseCase;

  StreamSubscription<Either<String, UserEntity>>? _userSubscription;

  late UserEntity userEntity;

  Future<void> getCurrentUser() async {
    emit(GetCurrentUserLoading());

    final userID = _getUserIDUseCase();

    if (userID == null) {
      emit(GetCurrentUserInitial());
      return;
    }

    final result = await _getCurrentUserUseCase(userID: userID);

    result.fold(
      ifLeft: (code) => emit(GetCurrentUserFailure(code)),
      ifRight: (user) {
        userEntity = user;
        emit(GetCurrentUserSuccess(user));
      },
    );
  }

  // Listen to user changes
  void getCurrentUserStream() {
    emit(GetCurrentUserLoading());

    final userID = _getUserIDUseCase();

    if (userID == null) {
      emit(GetCurrentUserInitial());
      return;
    }

    _userSubscription?.cancel();

    _userSubscription = _getUserStreamUseCase(userID: userID).listen(
      (result) {
        result.fold(
          ifLeft: (code) {
            emit(GetCurrentUserFailure(code));
          },
          ifRight: (user) {
            userEntity = user;
            emit(GetCurrentUserSuccess(user));
          },
        );
      },
      onError: (error) {
        emit(GetCurrentUserFailure(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
