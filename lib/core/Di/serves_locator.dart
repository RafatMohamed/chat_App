import 'package:get_it/get_it.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/data/repo/user_repo_impl.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/domain/repo/user_repo.dart';
import 'package:scholar_chat_proj/features/chat/data/datasources/remot_data_source/chat_remote_data_source.dart';
import 'package:scholar_chat_proj/features/chat/data/repo/chat_repo_impl.dart';
import 'package:scholar_chat_proj/features/chat/domain/usecases/get_chat_stream_use_case.dart';
import 'package:scholar_chat_proj/features/chat/domain/usecases/send_message_chat_use_case.dart';

import '../../features/MainHomeAppView/data/datasources/remot_data_source/user_remote_data_source.dart';
import '../../features/MainHomeAppView/domain/usecases/delete_user_use_case.dart';
import '../../features/MainHomeAppView/domain/usecases/get_user_id_use_case.dart';
import '../../features/MainHomeAppView/domain/usecases/get_user_stream_use_case.dart';
import '../../features/MainHomeAppView/domain/usecases/get_user_use_case.dart';
import '../../features/MainHomeAppView/domain/usecases/get_users_filterd_use_case.dart';
import '../../features/MainHomeAppView/domain/usecases/get_users_use_case.dart';
import '../../features/MainHomeAppView/domain/usecases/update_user_use_case.dart';
import '../../features/MainHomeAppView/presentation/cubit/getCurrentUserCubit/get_current_user_cubit.dart';
import '../../features/MainHomeAppView/presentation/cubit/getUsersCubit/get_users_cubit.dart';
import '../../features/MainHomeAppView/presentation/cubit/updateCurrentUsercubit/update_user_cubit.dart';
import '../../features/auth/data/datasources/remot_data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/domain/repo/auth_repo.dart';
import '../../features/auth/domain/usecases/create_user_use_case.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/domain/usecases/logout_use_case.dart';
import '../../features/auth/domain/usecases/register_use_case.dart';
import '../../features/auth/domain/usecases/reset_password_use_case.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/chat/domain/repo/chat_repo.dart';
import '../../features/chat/domain/usecases/get_messages_stream_use_case.dart';
import '../../features/chat/presentation/cubit/chatCubit/chat_cubit.dart';
import '../../features/chat/presentation/cubit/getMessageCubit/get_message_cubit.dart';
import '../../features/chat/presentation/cubit/sendMessageCubit/send_message_cubit.dart';
import '../../features/search/presentation/cubit/search_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      userRemoteDataSource: getIt<UserRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSource(),
  );

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(userRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<ChatRepo>(
    () => ChatRepoImpl(chatRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton(() => RegisterUseCase(authRepo: getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(authRepo: getIt()));
  getIt.registerLazySingleton(() => LogOutUseCase(authRepo: getIt()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(authRepo: getIt()));
  getIt.registerLazySingleton(() => GetUserIDUseCase(authRepo: getIt()));
  getIt.registerLazySingleton(() => GetUserUseCase(userRepo: getIt()));
  getIt.registerLazySingleton(() => GetUserStreamUseCase(userRepo: getIt()));
  getIt.registerLazySingleton(() => CreateUserUseCase(userRepo: getIt()));
  getIt.registerLazySingleton(() => UpdateUserUseCase(userRepo: getIt()));
  getIt.registerLazySingleton(() => DeleteUserUseCase(userRepo: getIt()));
  getIt.registerLazySingleton(() => GetUsersUseCase(userRepo: getIt()));
  getIt.registerLazySingleton(() => GetUsersFilterUseCase(userRepo: getIt()));
  getIt.registerLazySingleton(() => GetChatStreamUseCase(chatRepo: getIt()));
  getIt.registerLazySingleton(() => SendMessageChatUseCase(chatRepo: getIt()));
  getIt.registerLazySingleton(
    () => GetMessagesStreamUseCase(chatRepo: getIt()),
  );

  getIt.registerFactory(
    () => AuthCubit(
      registerUseCase: getIt(),
      userIDUseCase: getIt(),
      loginUseCase: getIt(),
      logoutUseCase: getIt(),
      resetPasswordUseCase: getIt(),
    ),
  );

  getIt.registerFactory(() => SearchCubit(getUsersFilterUseCase: getIt()));

  getIt.registerFactory(() => GetUsersCubit(getUsersUseCase: getIt()));

  getIt.registerFactory(
    () => GetCurrentUserCubit(
      getCurrentUserUseCase: getIt(),
      getUserIDUseCase: getIt(),
      getUserStreamUseCase: getIt(),
    ),
  );

  getIt.registerFactory(
    () => UpdateUserCubit(updateUserUseCase: getIt(), userIDUseCase: getIt()),
  );

  getIt.registerFactory(
    () => ChatCubit(
      getChatStreamUseCase: getIt(),
      userIDUseCase: getIt(),
      getUserUseCase: getIt(),
    ),
  );

  getIt.registerFactory(
    () => SendMessageCubit(sendMessageUseCase: getIt(), userIDUseCase: getIt()),
  );

  getIt.registerFactory(
    () => GetMessagesCubit(
      getMessagesStreamUseCase: getIt(),
      getUserIdUseCase: getIt(),
    ),
  );
}
