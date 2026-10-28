import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';
import 'package:scholar_chat_proj/core/widgets/custom_search_text_field.dart';
import 'package:scholar_chat_proj/features/home/presentation/home_view.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CustomAppBarHome extends StatelessWidget {
  const CustomAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(AppTexts.appName, style: AppTextStyles.headingSmall),
                Text(
                  "Hello, Raafat",
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
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
                  height: 45,
                  width: 45,
                  child: Text(users[0].charName, style: AppTextStyles.userName),
                ),
                const CircleAvatar(
                  backgroundColor: AppColors.background,
                  radius: 7,
                  child: CircleAvatar(
                    backgroundColor: AppColors.online,
                    radius: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: Sizes.s20),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pushNamed(context, Routes.searchView);
          },
          child: const AbsorbPointer(child: CustomSearchText()),
        ),
      ],
    );
  }
}
