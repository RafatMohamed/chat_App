import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/widgets/error_indicator.dart';
import 'package:scholar_chat_proj/core/widgets/loading_indicator.dart';
import 'package:scholar_chat_proj/features/chat/presentation/cubit/chatCubit/chat_cubit.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/chat_empty_home_view.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/chat_home_view.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/cutom_app_bar_home.dart';

import '../../../core/resources/app_text_styles.dart';
import '../../../core/resources/app_texts.dart';
import '../../../core/resources/values_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const LoadingIndicator();
          }
          if (state is ChatFailed) {
            log(state.message);
            return ErrorIndicator(message: state.message);
          }
          if (state is ChatLoaded) {
            final usersDefault = state.chats;
            return SafeArea(
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
                        Text(
                          "(${usersDefault.length})",
                          style: AppTextStyles.hint,
                        ),
                      ],
                    ),
                    Expanded(
                      child: usersDefault.isNotEmpty
                          ? ChatsHomeView(chats: usersDefault)
                          : const ChatEmptyHomeView(),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
