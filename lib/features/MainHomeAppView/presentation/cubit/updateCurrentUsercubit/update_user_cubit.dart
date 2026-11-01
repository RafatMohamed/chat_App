import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/domain/entities/user_entities.dart';
import '../../../domain/usecases/get_user_id_use_case.dart';
import '../../../domain/usecases/update_user_use_case.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit({
    required this._updateUserUseCase,
    required this._userIDUseCase,
  }) : super(UpdateUserInitial());

  final UpdateUserUseCase _updateUserUseCase;
  final GetUserIDUseCase _userIDUseCase;

  Future<void> updateUser({required UserEntity user}) async {
    emit(UpdateUserLoading());
    final userID = _userIDUseCase();

    if (userID == null) {
      emit(UpdateUserInitial());
      return;
    }

    final result = await _updateUserUseCase(uid: userID, user: user);

    result.fold(
      ifLeft: (code) => emit(UpdateUserError(code)),
      ifRight: (user) {
        emit(UpdateUserSuccess(user: user));
      },
    );
  }
}
