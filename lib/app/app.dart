import 'package:effective_mobile_test/presentation/screens/home.dart';
import 'package:effective_mobile_test/theme/color_resources.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: false).copyWith(
        scaffoldBackgroundColor: ColorResource.BLACK,
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return ColorResource.BLUE;
              }
              return ColorResource.GRAY_FIVE;
            },
          ),
          thumbColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return ColorResource.BLUE;
              }
              return Colors.grey.shade400;
            },
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      home: const HomePage(),
    );
  }
}
