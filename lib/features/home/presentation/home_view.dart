import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/widgets/error_indicator.dart';
import 'package:scholar_chat_proj/core/widgets/loading_indicator.dart';
import 'package:scholar_chat_proj/core/resources/color_manager.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';
import 'package:scholar_chat_proj/features/chat/presentation/cubit/chatCubit/chat_cubit.dart';
import 'package:scholar_chat_proj/features/groups/presentation/cubit/groupCubit/group_cubit.dart';
import 'package:scholar_chat_proj/features/groups/presentation/views/widgets/group_empty_home_view.dart';
import 'package:scholar_chat_proj/features/groups/presentation/views/widgets/groups_home_view.dart';
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
                    const SizedBox(height: Sizes.s20),
                    Expanded(
                      child: BlocBuilder<GroupCubit, GroupState>(
                        builder: (context, state) {
                          if (state is GroupLoading) {
                            return const LoadingIndicator();
                          }
                          if (state is GroupFailed) {
                            log(state.message);
                            return ErrorIndicator(message: state.message);
                          }
                          if (state is GroupLoaded) {
                            final groups = state.groups;
                            return Column(
                              children: [
                                Row(
                                  spacing: 8,
                                  children: [
                                    const Text(
                                      AppTexts.groups,
                                      style: AppTextStyles.titleMedium,
                                    ),
                                    Text(
                                      "(${groups.length})",
                                      style: AppTextStyles.hint,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.createGroupView,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.group_add_outlined,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: groups.isNotEmpty
                                      ? GroupsHomeView(groups: groups)
                                      : const GroupEmptyHomeView(),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
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
