import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';

import '../../../../../core/resources/app_text_styles.dart';
import '../../../../../core/resources/app_texts.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class CustomSearchItem extends StatelessWidget {
  const CustomSearchItem({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Insets.s12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            spacing: Insets.s12,
            children: [
              Stack(
                alignment: AlignmentGeometry.bottomEnd,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    alignment: AlignmentDirectional.center,
                    height: 50,
                    width: 50,
                    child: Text(
                      getUserChar(user.username),
                      style: AppTextStyles.userName,
                    ),
                  ),
                  if (user.isOnline != null && user.isOnline == true)
                    CircleAvatar(
                      backgroundColor: AppColors.background,
                      radius: 10,
                      child: CircleAvatar(
                        backgroundColor: user.isOnline!
                            ? AppColors.online
                            : null,
                        radius: 8,
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      user.username,
                      style: AppTextStyles.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: Insets.s8,
                      ),
                      child: Text(
                        user.bio ?? "",
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.chatView,
              // arguments: "RaafatMohamed@gmail.com",
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            padding: const EdgeInsets.all(Insets.s8),
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  SvgAssets.chat,
                  fit: BoxFit.fill,
                  colorFilter: const ColorFilter.mode(
                    AppColors.accent,
                    BlendMode.srcIn,
                  ),
                ),
                const Text(
                  AppTexts.message,
                  style: AppTextStyles.link,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
