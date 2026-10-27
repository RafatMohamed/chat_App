import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
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
    this.onTap,
    this.maxLines,
    this.prefixIcon,
    this.borderBackgroundColor,
    this.suffixIcon,
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
  final void Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

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
        Container(
          margin: const EdgeInsets.only(top: Insets.s5),
          decoration: BoxDecoration(
            color:
                widget.backgroundColor ??
                AppColors.background.withValues(alpha: .15),
            borderRadius: BorderRadius.circular(Sizes.s8),
            border: Border.all(
              color: widget.borderBackgroundColor ?? AppColors.border,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            style: textThem.titleLarge,
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: widget.cursorColor ?? AppColors.primary,
            onTap: widget.onTap,
            onEditingComplete: () {
              widget.focusNode?.unfocus();
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction:
                widget.nextFocus == null
                    ? TextInputAction.done
                    : TextInputAction.next,
            validator: (value) {
              if (widget.validation == null) {
                setState(() => errorText = null);
              } else {
                setState(() => errorText = widget.validation!(value));
              }
              return errorText;
            },
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
                        selectedIcon: const Icon(Icons.visibility),
                        icon: SvgPicture.asset(SvgAssets.visibilityOff),
                      )
                      : widget.suffixIcon,
              hintStyle: widget.hintTextStyle,
              border: InputBorder.none,
            ),
          ),
        ),
        errorText == null
            ? const SizedBox()
            : Padding(
              padding: const EdgeInsetsDirectional.only(
                top: Insets.s8,
                start: Insets.s8,
              ),
              child: Text(
                errorText!,
                style: AppTextStyles.error.copyWith(fontSize: 16),
              ),
            ),
      ],
    );
  }
}
