import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';
import 'package:scholar_chat_proj/core/widgets/app_logo.dart';
import 'package:scholar_chat_proj/core/widgets/custom_elevated_button.dart';

import '../../../core/constants/app_constant.dart';
import '../../../core/resources/app_text_styles.dart';
import '../../../core/resources/app_them.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/values_manager.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonThem = Theme.of(context).elevatedButtonTheme.style;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: "uniqe",
                child: Material(
                  color: Colors.transparent,
                  child: logoApp(
                    context: context,
                    title: AppConstant.appName,
                    desc: AppTexts.onboardingSubtitle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: Insets.s16,
                  end: Insets.s16,
                  top: Insets.s32,
                  bottom: Insets.s24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.welcomeTo(AppConstant.appName),
                      style: AppTextStyles.headingSmall.copyWith(
                        fontFamily: fontFamily,
                      ),
                    ),
                    Text(
                      AppTexts.onboardingDescription,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        fontFamily: fontFamily,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        CustomElevatedButton(
                          label: AppTexts.logIn,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.login,
                            );
                          },
                        ),
                        const SizedBox(height: Sizes.s16),
                        CustomElevatedButton(
                          label: AppTexts.createAccount,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.register,
                            );
                          },
                          buttonStyle: buttonThem?.copyWith(
                            backgroundColor: const WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                            shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(16),
                                ),
                                side: BorderSide(color: AppColors.border),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
