import 'package:flutter/material.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class ButtonProfileControl extends StatelessWidget {
  const ButtonProfileControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          label: AppTexts.editeProfile,
          textStyle: AppTextStyles.button.copyWith(color: AppColors.accent),
          buttonStyle: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(AppColors.surface),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
                side: const BorderSide(color: AppColors.border, width: 1.5),
              ),
            ),
          ),
          prefixIcon: const Icon(
            Icons.mode_edit_outline_outlined,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: Sizes.s10),
        CustomElevatedButton(
          label: AppTexts.logOut,
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.login);
          },
          textStyle: AppTextStyles.button.copyWith(color: AppColors.error),
          buttonStyle: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(AppColors.surface),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
                side: const BorderSide(color: AppColors.error, width: 1.5),
              ),
            ),
          ),
          prefixIcon: const Icon(Icons.login_outlined, color: AppColors.error),
        ),
      ],
    );
  }
}
