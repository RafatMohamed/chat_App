import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/resources/assets_manager.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/values_manager.dart';

class DefaultBottomNavigationBar extends StatelessWidget {
  const DefaultBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onCurrentIndexChange,
  });

  final int currentIndex;
  final Function(int index) onCurrentIndexChange;

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarModel> itemsNav = [
      BottomNavigationBarModel(iconPath: SvgAssets.chat, label: AppTexts.chat),
      BottomNavigationBarModel(
        iconPath: SvgAssets.search,
        label: AppTexts.search,
      ),
      BottomNavigationBarModel(
        iconPath: SvgAssets.profile,
        label: AppTexts.profile,
      ),
    ];
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: Insets.s24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
          style: BorderStyle.solid,
          width: 1.5,
        ),
      ),
      child: Row(
        children:
            itemsNav.asMap().entries.map((entry) {
              final index = entry.key;
              final isSelected = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    onCurrentIndexChange(index);
                  },
                  child: AnimatedContainer(
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 50),
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          entry.value.iconPath,
                          fit: BoxFit.fitHeight,
                          width: 30,
                          height: 25,
                          colorFilter: ColorFilter.mode(
                            isSelected
                                ? AppColors.textPrimary
                                : AppColors.textSecondary.withValues(
                                  alpha: 0.5,
                                ),
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          entry.value.label,
                          style: AppTextStyles.titleSmall.copyWith(
                            color:
                                isSelected
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary.withValues(
                                      alpha: 0.5,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class BottomNavigationBarModel {
  final String label;
  final String iconPath;

  BottomNavigationBarModel({required this.label, required this.iconPath});
}
