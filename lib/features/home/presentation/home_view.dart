import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/chat_empty_view.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/chat_view.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/cutom_app_bar_home.dart';

import '../../../core/resources/app_text_styles.dart';
import '../../../core/resources/app_texts.dart';
import '../../../core/resources/values_manager.dart';
import '../../MainHomeAppView/presentation/cubit/getUsersCubit/get_users_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final usersDefault = context.watch<GetUsersCubit>().users;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Insets.s18,
            horizontal: Insets.s16,
          ),
          child: Column(
            children: [
              const CustomAppBarHome(),
              const SizedBox(height: Sizes.s20),
              Row(
                spacing: 8,
                children: [
                  const Text(
                    AppTexts.recentChat,
                    style: AppTextStyles.titleMedium,
                  ),
                  Text("(${usersDefault.length})", style: AppTextStyles.hint),
                ],
              ),
              Expanded(
                child: usersDefault.isNotEmpty
                    ? ChatsView(users: usersDefault)
                    : const ChatEmptyView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
