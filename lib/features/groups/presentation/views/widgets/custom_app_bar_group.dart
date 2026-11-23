import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';

import '../../../../../core/resources/app_text_styles.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class CustomAppBarGroup extends StatelessWidget {
  const CustomAppBarGroup({
    super.key,
    required this.name,
    required this.membersCount,
  });

  final String name;
  final int membersCount;

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
        const SizedBox(width: Insets.s16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: AppTextStyles.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                AppTexts.membersCount(membersCount),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
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
