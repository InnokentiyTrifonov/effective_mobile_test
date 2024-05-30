import 'package:effective_mobile_test/presentation/screens/home.dart';
import 'package:effective_mobile_test/theme/color_resources.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorResource.BLACK,
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      home: const HomePage(),
    );
  }
}
