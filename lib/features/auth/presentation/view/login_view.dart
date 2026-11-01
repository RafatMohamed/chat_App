import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/resources/values_manager.dart';
import 'package:scholar_chat_proj/core/utils/ui_utils.dart';
import 'package:scholar_chat_proj/core/widgets/app_logo.dart';
import 'package:scholar_chat_proj/core/widgets/loading_indicator.dart';
import 'package:scholar_chat_proj/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:scholar_chat_proj/features/auth/presentation/cubit/auth_state.dart';
import 'package:scholar_chat_proj/features/auth/presentation/widgets/text_form_fields_login.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final FocusNode _emailFocus;

  late final TextEditingController _passwordController;
  late final FocusNode _passwordFocus;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocus = FocusNode();

    _passwordController = TextEditingController();
    _passwordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();

    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
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
                      title: AppTexts.welcomeBack,
                      desc: AppTexts.loginSubtitle,
                    ),
                  ),
                ),
                TextFormFieldsLogin(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  emailFocus: _emailFocus,
                  passwordFocus: _passwordFocus,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.forgetPassword);
                  },
                  child: const Text(
                    AppTexts.forgotPassword,
                    style: AppTextStyles.link,
                    textAlign: TextAlign.end,
                  ),
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      UIUtils.showMessage(state.message);
                    }
                    if (state is AuthSuccess) {
                      UIUtils.showMessage(AppTexts.logInSuccess);
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.mainAppView,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const LoadingIndicator();
                    }
                    return CustomElevatedButton(
                      label: AppTexts.logIn,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          log("Login Success");
                          context.read<AuthCubit>().login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: Sizes.s40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppTexts.dontHaveAccount,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.register,
                        );
                      },
                      child: const Text(
                        AppTexts.createAccount,
                        style: AppTextStyles.link,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
