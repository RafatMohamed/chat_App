import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_item_entity.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CustomChatHomeItem extends StatelessWidget {
  const CustomChatHomeItem({super.key, required this.chats});

  final ChatItemEntity chats;

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
                      getUserChar(chats.otherUser.username),
                      style: AppTextStyles.userName,
                    ),
                  ),
                  if (chats.otherUser.isOnline)
                    CircleAvatar(
                      backgroundColor: AppColors.background,
                      radius: 10,
                      child: CircleAvatar(
                        backgroundColor: chats.otherUser.isOnline
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
                      chats.otherUser.username,
                      style: AppTextStyles.titleMedium,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: Insets.s8,
                      ),
                      child: Text(
                        chats.chat.lastMessage,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: Insets.s16,
          children: [
            Text(
              DateFormat('hh:mm a').format(chats.chat.lastMessageAt),
              style: AppTextStyles.error.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 12,
              child: Text(
                "1",
                style: AppTextStyles.messageTime.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
