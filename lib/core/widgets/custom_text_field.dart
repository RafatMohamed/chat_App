import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.label,
    this.hint,
    this.isObscured = false,
    this.iconData,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor,
    this.readOnly = false,
    this.validation,
    this.onChange,
    this.maxLines,
    this.prefixIcon,
    this.borderBackgroundColor,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.isNewLine = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String? hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderBackgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;
  final void Function(String? label)? onChange;
  final void Function(String? label)? onFieldSubmitted;
  final bool? isNewLine;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hidden = widget.isObscured;

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
              padding: const EdgeInsets.only(top: Insets.s2),
              child: Text(
                widget.label!,
                style: widget.labelTextStyle ?? textThem.titleMedium,
              ),
            )
            : const SizedBox(),
        TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.maxLines ?? 1,
          controller: widget.controller,
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          style: textThem.titleLarge,
          obscureText: hidden,
          keyboardType: widget.textInputType,
          obscuringCharacter: '*',
          cursorColor: widget.cursorColor ?? AppColors.primary,
          onChanged: widget.onChange,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onEditingComplete: () {
            widget.focusNode?.unfocus();
            if (widget.nextFocus != null) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            }
          },
          textInputAction:
              widget.isNewLine!
                  ? TextInputAction.newline
                  : widget.nextFocus == null
                  ? TextInputAction.done
                  : TextInputAction.next,
          validator: widget.validation,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(Insets.s12),
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon,
            suffixIcon:
                widget.isObscured
                    ? IconButton(
                      onPressed: () => setState(() => hidden = !hidden),
                      iconSize: Sizes.s24,
                      splashRadius: Sizes.s1,
                      isSelected: !hidden,
                      color: widget.cursorColor,
                      selectedIcon: const Icon(
                        Icons.visibility,
                        color: AppColors.textSecondary,
                        size: Sizes.s24,
                      ),
                      icon: SvgPicture.asset(
                        SvgAssets.visibilityOff,
                        colorFilter: const ColorFilter.mode(
                          AppColors.textSecondary,
                          BlendMode.dst,
                        ),
                        height: Sizes.s24,
                      ),
                    )
                    : widget.suffixIcon,
            hintStyle: widget.hintTextStyle,
            border: InputBorder.none,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            errorStyle: AppTextStyles.error.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
