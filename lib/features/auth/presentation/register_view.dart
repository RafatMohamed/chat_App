import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/resources/values_manager.dart';
import 'package:scholar_chat_proj/core/widgets/app_logo.dart';
import 'package:scholar_chat_proj/features/auth/presentation/widgets/text_form_fields_register.dart';

import '../../../core/resources/app_text_styles.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/routes/routes.dart';
import '../../../core/widgets/custom_elevated_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;
  late final FocusNode _emailFocus;

  late final TextEditingController _passwordController;
  late final FocusNode _passwordFocus;

  late final TextEditingController _nameController;
  late final FocusNode _nameFocus;

  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocus;

  late final TextEditingController _confirmPasswordController;
  late final FocusNode _confirmPasswordFocus;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocus = FocusNode();

    _passwordController = TextEditingController();
    _passwordFocus = FocusNode();

    _nameController = TextEditingController();
    _nameFocus = FocusNode();

    _phoneController = TextEditingController();
    _phoneFocus = FocusNode();

    _confirmPasswordController = TextEditingController();
    _confirmPasswordFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.s16,
            vertical: Insets.s8,
          ),
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
                      title: AppTexts.createAccount,
                      desc: AppTexts.registerSubtitle,
                    ),
                  ),
                ),
                TextFormFieldsRegister(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  emailFocus: _emailFocus,
                  passwordFocus: _passwordFocus,
                  nameController: _nameController,
                  phoneController: _phoneController,
                  confirmPasswordController: _confirmPasswordController,
                  nameFocus: _nameFocus,
                  phoneFocus: _phoneFocus,
                  confirmPasswordFocus: _confirmPasswordFocus,
                ),
                CustomElevatedButton(
                  label: AppTexts.createAccount,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      log("Register Success");
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.mainAppView,
                      );
                    }
                  },
                ),
                const SizedBox(height: Sizes.s40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppTexts.alreadyHaveAccount,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                      child: const Text(
                        AppTexts.logIn,
                        style: AppTextStyles.link,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.s24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();

    _passwordController.dispose();
    _passwordFocus.dispose();

    _nameController.dispose();
    _nameFocus.dispose();

    _confirmPasswordFocus.dispose();
    _confirmPasswordController.dispose();

    _phoneFocus.dispose();
    _phoneController.dispose();

    super.dispose();
  }
}
