import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/routes/route_generator.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';

import 'core/Di/serves_locator.dart';
import 'core/app_bloc_observer.dart';
import 'core/resources/app_them.dart';
import 'features/MainHomeAppView/presentation/cubit/getCurrentUserCubit/get_current_user_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  Bloc.observer = AppBlocObserver();
  // IsFirstOpenApp.initSharedStorge();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final isFirstOpen = IsFirstOpenApp.getIsFirstOpen();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(
          create: (context) =>
              getIt<GetCurrentUserCubit>()..getCurrentUserStream(),
        ),
      ],
      child: const CustomMaterialApp(),
    );
  }
}

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    final getUser = context.read<AuthCubit>().getCurrentUserID();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTexts.appName,
      theme: AppThem.darkThem(),
      initialRoute: getUser == null ? Routes.onBoarding : Routes.mainAppView,
      routes: RouteGenerator.routes,
    );
  }
}
