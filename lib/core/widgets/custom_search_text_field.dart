import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/app_text_styles.dart';
import '../resources/app_texts.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import 'custom_text_field.dart';

class CustomSearchText extends StatefulWidget {
  const CustomSearchText({super.key, this.suffixIcon, this.onChange});

  final Widget? suffixIcon;
  final ValueChanged<String?>? onChange;

  @override
  State<CustomSearchText> createState() => _CustomSearchTextState();
}

class _CustomSearchTextState extends State<CustomSearchText> {
  late final TextEditingController searchController;
  late final FocusNode focusNode;

  @override
  void initState() {
    searchController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: searchController,
      textInputType: TextInputType.emailAddress,
      onChange: (label) {
        label = label?.trim();
        if (label == null || label.isEmpty) {
          widget.onChange?.call("");
          return;
        }
        widget.onChange?.call(label);
        label = searchController.text;
      },
      suffixIcon: widget.suffixIcon == null
          ? null
          : SizedBox(
              width: 48,
              height: 48,
              child: IconButton(
                onPressed: () {
                  searchController.clear();
                  widget.onChange?.call("");
                },
                icon: widget.suffixIcon!,
              ),
            ),
      focusNode: focusNode,
      prefixIcon: SvgPicture.asset(
        SvgAssets.search,
        fit: BoxFit.scaleDown,
        width: 16,
        colorFilter: const ColorFilter.mode(AppColors.accent, BlendMode.srcIn),
      ),
      hint: AppTexts.searchAbout,
      hintTextStyle: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
