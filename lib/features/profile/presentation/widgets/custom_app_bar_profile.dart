import 'package:flutter/material.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/color_manager.dart';

class CustomAppBarProfile extends StatelessWidget {
  const CustomAppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(AppTexts.myProfile, style: AppTextStyles.headingSmall),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          child: const Text("ACTIVE", style: AppTextStyles.bodySmall),
        ),
      ],
    );
  }
}
