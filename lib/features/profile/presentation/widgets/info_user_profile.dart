import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';
import 'package:scholar_chat_proj/core/widgets/loading_indicator.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../MainHomeAppView/presentation/cubit/getCurrentUserCubit/get_current_user_cubit.dart';

class InfoUserProfile extends StatelessWidget {
  const InfoUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCurrentUserCubit, GetCurrentUserState>(
      builder: (context, state) {
        if (state is GetCurrentUserLoading) {
          return const LoadingIndicator();
        }
        if (state is GetCurrentUserSuccess) {
          final user = state.user;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    height: 120,
                    width: 120,
                    child: Text(
                      getUserChar(user.username),
                      style: AppTextStyles.displayLarge,
                    ),
                  ),
                  if (user.isOnline)
                    CircleAvatar(
                      backgroundColor: AppColors.background,
                      radius: 20,
                      child: CircleAvatar(
                        backgroundColor: user.isOnline
                            ? AppColors.online
                            : null,
                        radius: 10,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: Sizes.s14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user.username,
                    style: AppTextStyles.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: Insets.s8),
                    child: Text(
                      user.bio ?? "",
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
