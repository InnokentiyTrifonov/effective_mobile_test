import 'package:effective_mobile_test/core/navigation.dart';
import 'package:effective_mobile_test/core/theme/string_resources.dart';
import 'package:flutter/material.dart';

class HotTickets extends StatelessWidget {
  const HotTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(StringResource.hotTickets, textAlign: TextAlign.center),
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
