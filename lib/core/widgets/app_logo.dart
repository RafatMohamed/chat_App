import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';
import 'package:scholar_chat_proj/core/resources/app_them.dart';
import 'package:scholar_chat_proj/core/resources/assets_manager.dart';
import 'package:scholar_chat_proj/core/resources/color_manager.dart';
import 'package:scholar_chat_proj/core/resources/values_manager.dart';

Widget logoApp({
  required BuildContext context,
  required String title,
  required String desc,
}) {
  return Column(
    spacing: Insets.s8,
    children: [
      Lottie.asset(
        ImageAssets.logoAnimation,
        fit: BoxFit.fitHeight,
        alignment: AlignmentGeometry.center,
        animate: true,
        backgroundLoading: true,
        height: context.height * 0.25,
        width: double.infinity,
      ),
      Text(
        title,
        style: AppTextStyles.displayLarge.copyWith(fontFamily: fontFamily),
      ),
      Text(
        desc,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textSecondary,
          fontFamily: fontFamily,
        ),
      ),
    ],
  );
}
