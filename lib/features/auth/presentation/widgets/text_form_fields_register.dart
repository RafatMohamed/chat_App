import 'package:flutter/material.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_fade_animation.dart';
import '../../../../core/widgets/custom_text_field.dart';

class TextFormFieldsRegister extends StatelessWidget {
  const TextFormFieldsRegister({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.nameController,
    required this.phoneController,
    required this.confirmPasswordController,
    required this.nameFocus,
    required this.phoneFocus,
    required this.confirmPasswordFocus,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final FocusNode nameFocus;
  final FocusNode phoneFocus;
  final FocusNode confirmPasswordFocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideUpAnimation(
          child: CustomTextField(
            controller: nameController,
            focusNode: nameFocus,
            textInputType: TextInputType.name,
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
        SlideUpAnimation(
          delay: const Duration(milliseconds: 1500),
          child: CustomTextField(
            focusNode: passwordFocus,
            controller: passwordController,
            textInputType: TextInputType.visiblePassword,
            prefixIcon: const Icon(
              Icons.lock_clock_outlined,
              size: Sizes.s24,
              color: AppColors.textSecondary,
            ),
            validation: Validator.validatePassword,
            hint: AppTexts.createPassword,
            isObscured: true,
            hintTextStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        SlideUpAnimation(
          delay: const Duration(milliseconds: 2000),
          child: CustomTextField(
            nextFocus: confirmPasswordFocus,
            controller: confirmPasswordController,
            textInputType: TextInputType.visiblePassword,
            prefixIcon: const Icon(
              Icons.lock_clock_outlined,
              size: Sizes.s24,
              color: AppColors.textSecondary,
            ),
            validation: (val) {
              return Validator.validateConfirmPassword(
                val,
                passwordController.text,
              );
            },
            hint: AppTexts.confirmYourPassword,
            isObscured: true,
            hintTextStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
