import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';

import '../../../domain/usecases/get_users_use_case.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit({required this._getUsersUseCase}) : super(GetUsersInitial());

  final GetUsersUseCase _getUsersUseCase;

  List<UserEntity> users = [];

  Future<void> getUsers() async {
    emit(GetUsersLoading());
    final result = await _getUsersUseCase.call();
    result.fold(
      ifLeft: (l) => emit(GetUsersFailed(l)),
      ifRight: (r) {
        users = r;
        emit(GetUsersLoaded(users: users));
      },
    );
  }
}
