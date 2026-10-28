import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholar_chat_proj/core/resources/assets_manager.dart';

import '../../../../../core/resources/app_text_styles.dart';
import '../../../../../core/resources/app_texts.dart';
import '../../../../../core/resources/app_them.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class SearchEmptyView extends StatelessWidget {
  const SearchEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: context.height * 0.15),
          SvgPicture.asset(
            SvgAssets.emptySearch,
            fit: BoxFit.fill,
            height: context.height * 0.25,
            width: double.infinity,
          ),
          const Text(
            AppTexts.findYourPeople,
            style: AppTextStyles.headingSmall,
          ),
          const SizedBox(height: Insets.s8),
          Text(
            AppTexts.noSearchDesc,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.s32),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            width: context.width * 0.4,
            padding: const EdgeInsets.all(Insets.s8),
            child: const Text(
              AppTexts.inviteContact,
              style: AppTextStyles.link,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
