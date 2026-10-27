import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/resources/values_manager.dart';
import 'package:scholar_chat_proj/core/utils/validator.dart';
import 'package:scholar_chat_proj/core/widgets/app_logo.dart';
import 'package:scholar_chat_proj/core/widgets/custom_text_field.dart';

import '../../../core/resources/app_text_styles.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_fade_animation.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final TextEditingController _emailController;
  late final FocusNode _emailFocus;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  bool isValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.s16,
          vertical: Insets.s8,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: Insets.s20,
              children: [
                Hero(
                  tag: "uniqe",
                  child: Material(
                    color: Colors.transparent,
                    child: logoApp(
                      context: context,
                      title: AppTexts.welcomeBack,
                      desc: AppTexts.loginSubtitle,
                    ),
                  ),
                ),
                SlideUpAnimation(
                  child: CustomTextField(
                    textInputType: TextInputType.emailAddress,
                    label: AppTexts.emailAddress,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      size: Sizes.s24,
                      color: AppColors.textSecondary,
                    ),
                    onChange: (email) {
                      setState(() {
                        isValidate = Validator.validateEmail(email) == null;
                      });
                    },
                    nextFocus: _emailFocus,
                    controller: _emailController,
                    validation: (val) {
                      return Validator.validateEmail(val);
                    },
                    hint: AppTexts.enterYourEmail,
                    hintTextStyle: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.s28),
                CustomElevatedButton(
                  label: AppTexts.resetPassword,
                  buttonStyle:
                      !isValidate
                          ? const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                          )
                          : null,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      log("Reset Password Success");
                    }
                  },
                ),
                const SizedBox(height: Sizes.s28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
