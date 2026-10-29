import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/app_them.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class MessagesEmptyView extends StatelessWidget {
  const MessagesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          SvgAssets.noMessageYet,
          fit: BoxFit.fill,
          height: context.height * 0.2,
          width: double.infinity,
        ),
        const SizedBox(height: Insets.s16),
        const Text(AppTexts.noMessageYet, style: AppTextStyles.headingSmall),
        const SizedBox(height: Insets.s8),
        Text(
          AppTexts.noMessagesDesc,
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
              SvgPicture.asset(SvgAssets.helloIcon, fit: BoxFit.fill),
              const Text(
                AppTexts.sayHello,
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
