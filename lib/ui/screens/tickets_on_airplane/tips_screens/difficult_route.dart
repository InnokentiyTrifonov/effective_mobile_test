import 'package:effective_mobile_test/core/navigation.dart';
import 'package:effective_mobile_test/core/theme/string_resources.dart';
import 'package:flutter/material.dart';

class DifficultRoute extends StatelessWidget {
  const DifficultRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(StringResource.difficultRoute, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigation.goBack(),
              child: const Text(StringResource.goBack),
            ),
          ],
        ),
      ),
    );
  }
}
