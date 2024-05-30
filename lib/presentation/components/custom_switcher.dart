import 'package:effective_mobile_test/theme/color_resources.dart';
import 'package:flutter/material.dart';

class CustomSwitcher extends StatelessWidget {
  final bool isSwitched;
  final void Function(bool) onChanged;
  const CustomSwitcher({
    super.key,
    required this.isSwitched,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Switch(
        thumbColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return ColorResource.BLUE;
            }
            return Colors.grey.shade400;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return ColorResource.BLUE;
            }
            return ColorResource.GRAY_FIVE;
          },
        ),
        value: isSwitched,
        onChanged: onChanged,
      ),
    );
  }
}
