import 'package:effective_mobile_test/core/theme/style_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  /// Max width and height of prefixIcon is 32
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.hintText,
    required this.controller,
    this.textInputAction,
    this.suffixIcon,
    this.suffixIconPressed,
    this.onSubmitted,
  });
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final void Function()? suffixIconPressed;
  final void Function(String)? onSubmitted;

  Widget? _prefixIconCustomized() {
    if (prefixIcon != null) {
      return Container(
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        child: prefixIcon,
      );
    }
    return null;
  }

  Widget? _suffixIconCustomized() {
    if (suffixIcon != null) {
      return GestureDetector(
        onTap: suffixIconPressed,
        child: SizedBox(
          width: 18,
          height: 18,
          child: Padding(padding: const EdgeInsets.only(top: 5), child: suffixIcon),
        ),
      );
    }
    return null;
  }

  final textStyle = const TextStyle(
    fontSize: FontSizeResource.sixTeen,
    fontFamily: FontFamilyResource.regular,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[а-яА-ЯёЁ]'))],
      decoration: InputDecoration(
        suffix: _suffixIconCustomized(),
        prefixIcon: _prefixIconCustomized(),
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 32,
          maxHeight: 24,
          minHeight: 24,
          minWidth: 32,
        ),
        contentPadding: EdgeInsets.zero,
        isDense: true,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: textStyle,
      ),
      style: textStyle,
      controller: controller,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
    );
  }
}
