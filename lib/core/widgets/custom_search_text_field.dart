import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholar_chat_proj/features/home/presentation/home_view.dart';

import '../resources/app_text_styles.dart';
import '../resources/app_texts.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import 'custom_text_field.dart';

class CustomSearchText extends StatefulWidget {
  const CustomSearchText({super.key, this.suffixIcon});

  final Widget? suffixIcon;

  @override
  State<CustomSearchText> createState() => _CustomSearchTextState();
}

class _CustomSearchTextState extends State<CustomSearchText> {
  late final TextEditingController searchController;
  late final FocusNode focusNode;
  late final List<UserModel> allUser;

  @override
  void initState() {
    searchController = TextEditingController();
    focusNode = FocusNode();
    allUser = List<UserModel>.from(users);
    super.initState();
  }

  void onChange(String label) {
    users =
        allUser.where((element) {
          return element.name.toLowerCase().contains(label.toLowerCase());
        }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: searchController,
      textInputType: TextInputType.emailAddress,
      onChange: (label) {
        onChange(label ?? "");
        setState(() {});
      },
      suffixIcon:
          widget.suffixIcon == null
              ? null
              : SizedBox(
                width: 48,
                height: 48,
                child: IconButton(
                  onPressed: () {
                    searchController.clear();
                    onChange("");
                    setState(() {});
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
