import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholar_chat_proj/features/home/presentation/home_view.dart';

import '../../../../../core/resources/app_text_styles.dart';
import '../../../../../core/resources/app_texts.dart';
import '../../../../../core/resources/app_them.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import 'custom_search_item.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key, required this.users});

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            // padding: const EdgeInsets.symmetric(vertical: Insets.s12),
            itemBuilder: (context, index) {
              final item = users[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.s14),
                child: CustomSearchItem(item: item),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          width: context.width,
          padding: const EdgeInsets.all(Insets.s8),
          child: Row(
            spacing: 16,
            children: [
              SvgPicture.asset(
                SvgAssets.findPeopleIcon,
                fit: BoxFit.fill,
                colorFilter: const ColorFilter.mode(
                  AppColors.accent,
                  BlendMode.srcIn,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppTexts.cantFindPeople,
                    style: AppTextStyles.link.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                  Text(
                    AppTexts.inviteQr,
                    style: AppTextStyles.link.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  alignment: AlignmentGeometry.center,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.accent,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height * 0.1),
      ],
    );
  }
}
