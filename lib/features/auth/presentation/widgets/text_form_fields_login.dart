import 'package:flutter/material.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_fade_animation.dart';
import '../../../../core/widgets/custom_text_field.dart';

class TextFormFieldsLogin extends StatelessWidget {
  const TextFormFieldsLogin({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideUpAnimation(
          child: CustomTextField(
            textInputType: TextInputType.emailAddress,
            label: AppTexts.emailAddress,
            prefixIcon: const Icon(
              Icons.email_outlined,
              size: Sizes.s24,
              color: AppColors.textSecondary,
            ),
            nextFocus: emailFocus,
            controller: emailController,
            validation: Validator.validateEmail,
            hint: AppTexts.enterYourEmail,
            hintTextStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        SlideUpAnimation(
          delay: const Duration(seconds: 1),
          child: CustomTextField(
            label: AppTexts.password,
            focusNode: passwordFocus,
            controller: passwordController,
            textInputType: TextInputType.visiblePassword,
            prefixIcon: const Icon(
              Icons.lock_clock_outlined,
              size: Sizes.s24,
              color: AppColors.textSecondary,
            ),
            validation: Validator.validatePassword,
            hint: AppTexts.enterYourPassword,
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
