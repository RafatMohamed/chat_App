import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../MainHomeAppView/domain/usecases/get_users_filterd_use_case.dart';
import '../../../auth/domain/entities/user_entities.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this._getUsersFilterUseCase}) : super(SearchInitial());

  final GetUsersFilterUseCase _getUsersFilterUseCase;

  List<UserEntity> users = [];

  Future<void> getUsersFiltered({required String query}) async {
    emit(SearchLoading());

    if (query.trim().isEmpty) {
      users = [];
      emit(SearchLoaded(users));
      return;
    }
    final result = await _getUsersFilterUseCase.call(query: query);
    result.fold(
      ifLeft: (l) => emit(SearchError(l)),
      ifRight: (r) {
        users = r;
        emit(SearchLoaded(users));
      },
    );
  }
}
