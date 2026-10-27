import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  const CustomElevatedButton({
    super.key,
    this.prefixIcon,
    this.textStyle,
    this.suffixIcon,
    required this.label,
    this.onTap,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    final buttonThem = Theme.of(context).elevatedButtonTheme.style;
    return ElevatedButton(
      onPressed: onTap,
      style: buttonStyle ?? buttonThem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIcon ?? const SizedBox(),
          const SizedBox(width: 24),
          Text(label, style: textStyle ?? AppTextStyles.button),
          const SizedBox(width: 27),
          suffixIcon ?? const SizedBox(),
        ],
      ),
    );
  }
}
