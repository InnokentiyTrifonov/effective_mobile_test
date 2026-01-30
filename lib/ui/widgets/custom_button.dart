import 'package:effective_mobile_test/core/theme/color_resources.dart';
import 'package:effective_mobile_test/core/theme/style_resources.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.color, required this.onPressed, required this.text});
  final Color color;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(RadiusResource.eight),
      color: color,
      child: SizedBox(
        width: double.maxFinite,
        height: 50,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: FontFamilyResource.regular,
                color: ColorResource.white,
                fontSize: FontSizeResource.sixTeen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
