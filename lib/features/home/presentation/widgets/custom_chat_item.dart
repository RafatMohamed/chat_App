import 'package:flutter/material.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../home_view.dart';

class CustomChatItem extends StatelessWidget {
  const CustomChatItem({super.key, required this.item});

  final UserModel item;

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
                    child: Text(item.charName, style: AppTextStyles.userName),
                  ),
                  if (item.isOnline != null && item.isOnline == true)
                    CircleAvatar(
                      backgroundColor: AppColors.background,
                      radius: 10,
                      child: CircleAvatar(
                        backgroundColor:
                            item.isOnline! ? AppColors.online : null,
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
                    Text(item.name, style: AppTextStyles.titleMedium),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: Insets.s8,
                      ),
                      child: Text(
                        "Hello, Raafat How are you Hello, Raafat How are you Hello, Raafat How are you Hello, Raafat How are you Hello, Raafat How are you ",
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
              "10:42 AM",
              style: AppTextStyles.error.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 12,
              child: Text(
                "2",
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
