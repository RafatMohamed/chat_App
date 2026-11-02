import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';
import 'package:scholar_chat_proj/core/widgets/custom_search_text_field.dart';
import 'package:scholar_chat_proj/core/widgets/loading_indicator.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../MainHomeAppView/presentation/cubit/getCurrentUserCubit/get_current_user_cubit.dart';

class CustomAppBarHome extends StatelessWidget {
  const CustomAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCurrentUserCubit, GetCurrentUserState>(
      builder: (context, state) {
        if (state is GetCurrentUserLoading) {
          return const LoadingIndicator();
        }
        if (state is GetCurrentUserFailure) {
          log(state.message);
          return Text(state.message);
        }
        if (state is GetCurrentUserSuccess) {
          final user = state.user;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        AppTexts.appName,
                        style: AppTextStyles.headingSmall,
                      ),
                      Text(
                        "Hello, ${user.username}",
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: AlignmentGeometry.bottomEnd,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        alignment: AlignmentDirectional.center,
                        height: 45,
                        width: 45,
                        child: Text(
                          getUserChar(user.username),
                          style: AppTextStyles.userName,
                        ),
                      ),
                      if (user.isOnline)
                        const CircleAvatar(
                          backgroundColor: AppColors.background,
                          radius: 7,
                          child: CircleAvatar(
                            backgroundColor: AppColors.online,
                            radius: 5,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Sizes.s20),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pushNamed(context, Routes.searchView);
                },
                child: const AbsorbPointer(child: CustomSearchText()),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
