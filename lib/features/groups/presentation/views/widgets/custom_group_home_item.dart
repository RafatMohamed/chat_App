import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';
import 'package:scholar_chat_proj/features/groups/domain/entities/group_entities.dart';

import '../../../../../core/resources/app_text_styles.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class CustomGroupHomeItem extends StatelessWidget {
  const CustomGroupHomeItem({super.key, required this.group});

  final GroupEntity group;

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
                  getUserChar(group.name),
                  style: AppTextStyles.userName,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      group.name,
                      style: AppTextStyles.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: Insets.s8,
                      ),
                      child: Text(
                        group.lastMessage,
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
        Text(
          DateFormat('hh:mm a').format(group.lastMessageAt),
          style: AppTextStyles.error.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
