import 'package:flutter/material.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/home_view.dart';

class InfoUserProfile extends StatelessWidget {
  const InfoUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              height: 120,
              width: 120,
              child: Text(
                users.first.charName,
                style: AppTextStyles.displayLarge,
              ),
            ),
            if (users.first.isOnline == true)
              CircleAvatar(
                backgroundColor: AppColors.background,
                radius: 20,
                child: CircleAvatar(
                  backgroundColor:
                      users.first.isOnline == true ? AppColors.online : null,
                  radius: 10,
                ),
              ),
          ],
        ),
        const SizedBox(height: Sizes.s14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              users.first.name,
              style: AppTextStyles.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: Insets.s8),
              child: Text(
                users.first.bio,
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
      ],
    );
  }
}
