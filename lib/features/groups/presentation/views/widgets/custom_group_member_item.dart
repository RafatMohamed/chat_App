import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';

import '../../../../../core/resources/app_text_styles.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class CustomGroupMemberItem extends StatelessWidget {
  const CustomGroupMemberItem({
    super.key,
    required this.user,
    required this.isSelected,
    required this.onTap,
  });

  final UserEntity user;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        spacing: Insets.s12,
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
          Expanded(
            child: Text(
              user.username,
              style: AppTextStyles.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
