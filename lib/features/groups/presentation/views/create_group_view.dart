import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/resources/color_manager.dart';
import 'package:scholar_chat_proj/core/resources/values_manager.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';
import 'package:scholar_chat_proj/core/utils/ui_utils.dart';
import 'package:scholar_chat_proj/core/widgets/custom_elevated_button.dart';
import 'package:scholar_chat_proj/core/widgets/custom_text_field.dart';
import 'package:scholar_chat_proj/core/widgets/error_indicator.dart';
import 'package:scholar_chat_proj/core/widgets/loading_indicator.dart';
import 'package:scholar_chat_proj/features/MainHomeAppView/presentation/cubit/getUsersCubit/get_users_cubit.dart';
import 'package:scholar_chat_proj/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:scholar_chat_proj/features/groups/presentation/cubit/createGroupCubit/create_group_cubit.dart';
import 'package:scholar_chat_proj/features/groups/presentation/views/widgets/custom_group_member_item.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final TextEditingController nameController = TextEditingController();
  final Set<String> selectedMembers = {};

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthCubit>().getCurrentUserID();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Insets.s18,
            horizontal: Insets.s16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsetsGeometry.zero,
                    iconSize: 24,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: Insets.s8),
                  const Text(
                    AppTexts.createGroup,
                    style: AppTextStyles.headingSmall,
                  ),
                ],
              ),
              const SizedBox(height: Sizes.s20),
              CustomTextField(
                label: AppTexts.groupName,
                hint: AppTexts.enterGroupName,
                controller: nameController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: Sizes.s20),
              const Text(
                AppTexts.selectMembers,
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: Sizes.s10),
              Expanded(
                child: BlocBuilder<GetUsersCubit, GetUsersState>(
                  builder: (context, state) {
                    if (state is GetUsersLoading) {
                      return const LoadingIndicator();
                    }
                    if (state is GetUsersFailed) {
                      return ErrorIndicator(message: state.error);
                    }
                    if (state is GetUsersLoaded) {
                      final users = state.users
                          .where((user) => user.uid != currentUserId)
                          .toList();
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final uid = user.uid.toString();
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Insets.s14,
                            ),
                            child: CustomGroupMemberItem(
                              user: user,
                              isSelected: selectedMembers.contains(uid),
                              onTap: () {
                                setState(() {
                                  if (selectedMembers.contains(uid)) {
                                    selectedMembers.remove(uid);
                                  } else {
                                    selectedMembers.add(uid);
                                  }
                                });
                              },
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: Sizes.s16),
              BlocConsumer<CreateGroupCubit, CreateGroupState>(
                listener: (context, state) {
                  if (state is CreateGroupLoading) {
                    UIUtils.showLoading(context);
                  }
                  if (state is CreateGroupFailure) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(state.message);
                  }
                  if (state is CreateGroupSuccess) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(AppTexts.groupCreatedSuccess);
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.groupChatView,
                      arguments: state.group,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    label: AppTexts.createGroup,
                    onTap: () {
                      if (nameController.text.trim().isEmpty) {
                        UIUtils.showMessage(AppTexts.fieldRequired);
                        return;
                      }
                      if (selectedMembers.isEmpty) {
                        UIUtils.showMessage(AppTexts.selectOneMemberAtLeast);
                        return;
                      }
                      context.read<CreateGroupCubit>().createGroup(
                        name: nameController.text,
                        members: selectedMembers.toList(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    nameController.dispose();
    super.dispose();
  }
}
