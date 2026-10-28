import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';
import 'package:scholar_chat_proj/features/auth/presentation/forget_password_view.dart';
import 'package:scholar_chat_proj/features/auth/presentation/login_view.dart';
import 'package:scholar_chat_proj/features/auth/presentation/register_view.dart';
import 'package:scholar_chat_proj/features/boarding/UI/on_boarding_view.dart';
import 'package:scholar_chat_proj/features/home/presentation/home_view.dart';

import '../../features/MainHomeAppView/view/main_app_view.dart';
import '../../features/profile/presentation/profile_view.dart';
import '../../features/search/presentation/search_view.dart';

class RouteGenerator {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
        Routes.onBoarding: (context) => const OnBoardingView(),
        Routes.login: (context) => const LoginView(),
        Routes.register: (context) => const RegisterView(),
        Routes.forgetPassword: (context) => const ForgetPasswordView(),
        Routes.mainAppView: (context) => const MainAppView(),
        Routes.homeView: (context) => const HomeView(),
        Routes.searchView: (context) => const SearchView(),
        Routes.profileView: (context) => const ProfileView(),
      };
}
