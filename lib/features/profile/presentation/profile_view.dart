import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/features/profile/presentation/widgets/button_profile_control.dart';
import 'package:scholar_chat_proj/features/profile/presentation/widgets/custom_app_bar_profile.dart';
import 'package:scholar_chat_proj/features/profile/presentation/widgets/info_user_profile.dart';
import 'package:scholar_chat_proj/features/profile/presentation/widgets/text_form_fields_profile.dart';

import '../../../../core/resources/values_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final TextEditingController _emailController;
  late final FocusNode _emailFocus;

  late final TextEditingController _nameController;
  late final FocusNode _nameFocus;

  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocus;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController(text: "Raafat@gmail.com");
    _emailFocus = FocusNode();

    _nameController = TextEditingController(text: "Raafat Mohamed");
    _nameFocus = FocusNode();

    _phoneController = TextEditingController(text: "01014459420");
    _phoneFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Insets.s12,
            horizontal: Insets.s16,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CustomAppBarProfile(),
                  const SizedBox(height: Sizes.s28),
                  const InfoUserProfile(),
                  const SizedBox(height: Sizes.s1),
                  TextFormFieldsProfiles(
                    emailController: _emailController,
                    nameController: _nameController,
                    phoneController: _phoneController,
                    nameFocus: _nameFocus,
                    emailFocus: _emailFocus,
                    phoneFocus: _phoneFocus,
                  ),
                  const SizedBox(height: Sizes.s24),
                  const ButtonProfileControl(),
                ],
              ),
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

    _nameController.dispose();
    _nameFocus.dispose();

    _phoneFocus.dispose();
    _phoneController.dispose();

    super.dispose();
  }
}
