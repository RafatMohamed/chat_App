import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/app_them.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          SvgAssets.emptyChat,
          fit: BoxFit.fill,
          height: context.height * 0.25,
          width: double.infinity,
        ),
        const Text(AppTexts.noChatYet, style: AppTextStyles.headingSmall),
        const SizedBox(height: Insets.s8),
        Text(
          AppTexts.noChatDesc,
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
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                SvgAssets.findPeopleIcon,
                fit: BoxFit.fill,
                colorFilter: const ColorFilter.mode(
                  AppColors.accent,
                  BlendMode.srcIn,
                ),
              ),
              const Text(
                AppTexts.findPeople,
                style: AppTextStyles.link,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
