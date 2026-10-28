import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/widgets/custom_search_text_field.dart';

import '../../../../../core/resources/app_text_styles.dart';
import '../../../../../core/resources/app_texts.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class CustomAppBarSearch extends StatelessWidget {
  const CustomAppBarSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTexts.findPeople, style: AppTextStyles.headingSmall),
        SizedBox(height: Sizes.s20),
        CustomSearchText(
          suffixIcon: Icon(
            Icons.clear_outlined,
            color: AppColors.accent,
            size: 24,
          ),
        ),
      ],
    );
  }
}
