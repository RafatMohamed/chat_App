import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CustomAppBarMessages extends StatelessWidget {
  const CustomAppBarMessages({
    super.key,
    required this.name,
    this.isOnline = true,
  });

  final String name;
  final bool? isOnline;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
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
              child: Text(getUserChar(name), style: AppTextStyles.userName),
            ),
            const CircleAvatar(
              backgroundColor: AppColors.background,
              radius: 7,
              child: CircleAvatar(backgroundColor: AppColors.online, radius: 5),
            ),
          ],
        ),
        const SizedBox(width: Insets.s16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name, style: AppTextStyles.titleLarge),
            Text(
              "is Online",
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.online),
            ),
          ],
        ),
        const Spacer(flex: 1),
        IconButton(
          padding: EdgeInsetsGeometry.zero,
          iconSize: 24,
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_outlined,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
