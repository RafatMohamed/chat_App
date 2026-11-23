import 'package:flutter/material.dart';

import '../../../../../core/resources/app_text_styles.dart';
import '../../../../../core/resources/app_texts.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class GroupEmptyHomeView extends StatelessWidget {
  const GroupEmptyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppTexts.noGroupsYet, style: AppTextStyles.headingSmall),
        const SizedBox(height: Insets.s8),
        Text(
          AppTexts.noGroupsDesc,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
