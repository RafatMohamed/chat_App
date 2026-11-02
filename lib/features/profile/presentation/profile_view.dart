import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/Di/serves_locator.dart';
import 'package:scholar_chat_proj/core/widgets/loading_indicator.dart';
import 'package:scholar_chat_proj/features/profile/presentation/widgets/button_profile_control.dart';
import 'package:scholar_chat_proj/features/profile/presentation/widgets/custom_app_bar_profile.dart';
import 'package:scholar_chat_proj/features/profile/presentation/widgets/info_user_profile.dart';
import 'package:scholar_chat_proj/features/profile/presentation/widgets/text_form_fields_profile.dart';

import '../../../../core/resources/values_manager.dart';
import '../../MainHomeAppView/presentation/cubit/getCurrentUserCubit/get_current_user_cubit.dart';
import '../../MainHomeAppView/presentation/cubit/updateCurrentUsercubit/update_user_cubit.dart';
import '../../auth/domain/entities/user_entities.dart';

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
    _emailController = TextEditingController();
    _emailFocus = FocusNode();

    _nameController = TextEditingController();
    _nameFocus = FocusNode();

    _phoneController = TextEditingController();
    _phoneFocus = FocusNode();

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UpdateUserCubit>(),
      child: Scaffold(
        body: BlocBuilder<GetCurrentUserCubit, GetCurrentUserState>(
          builder: (context, state) {
            if (state is GetCurrentUserLoading) {
              return const LoadingIndicator();
            }
            if (state is GetCurrentUserSuccess) {
              final user = state.user;
              if (_emailController.text.isEmpty) {
                _emailController.text = user.email;
                _nameController.text = user.username;
                _phoneController.text = user.phoneNumber;
              }
              return SafeArea(
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
                          ButtonProfileControl(
                            onEditeProfile: () {
                              UserEntity user = UserEntity(
                                username: _nameController.text,
                                email: _emailController.text,
                                phoneNumber: _phoneController.text,
                                isOnline: true,
                              );
                              context.read<UpdateUserCubit>().updateUser(
                                user: user,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
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
