import 'package:flutter/material.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_fade_animation.dart';
import '../../../../core/widgets/custom_text_field.dart';

class TextFormFieldsProfiles extends StatelessWidget {
  const TextFormFieldsProfiles({
    super.key,
    required this.emailController,
    required this.nameController,
    required this.phoneController,
    required this.nameFocus,
    required this.emailFocus,
    required this.phoneFocus,
  });

  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final FocusNode emailFocus;
  final FocusNode nameFocus;
  final FocusNode phoneFocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Insets.s16,
      children: [
        SlideUpAnimation(
          child: CustomTextField(
            controller: nameController,
            focusNode: nameFocus,
            textInputType: TextInputType.name,
            label: AppTexts.fullName,
            labelTextStyle: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.person_2_outlined,
              size: Sizes.s24,
              color: AppColors.textSecondary,
            ),
            validation: Validator.validateFullName,
            hint: AppTexts.enterYourFullName,
            hintTextStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        SlideUpAnimation(
          delay: const Duration(milliseconds: 500),
          child: CustomTextField(
            focusNode: emailFocus,
            label: AppTexts.emailAddress,
            labelTextStyle: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            controller: emailController,
            textInputType: TextInputType.emailAddress,
            prefixIcon: const Icon(
              Icons.email_outlined,
              size: Sizes.s24,
              color: AppColors.textSecondary,
            ),
            validation: Validator.validateEmail,
            hint: AppTexts.enterYourEmail,
            hintTextStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        SlideUpAnimation(
          delay: const Duration(milliseconds: 1000),
          child: CustomTextField(
            focusNode: phoneFocus,
            label: AppTexts.phoneNumber,
            labelTextStyle: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            controller: phoneController,
            textInputType: TextInputType.phone,
            prefixIcon: const Icon(
              Icons.phone,
              size: Sizes.s24,
              color: AppColors.textSecondary,
            ),
            validation: Validator.validatePhoneNumber,
            hint: AppTexts.enterYourPhoneNumber,
            hintTextStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
