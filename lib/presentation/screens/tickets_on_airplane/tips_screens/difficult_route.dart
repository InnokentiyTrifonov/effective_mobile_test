import 'package:effective_mobile_test/app/service_locator.dart';
import 'package:effective_mobile_test/domain/navigator/navigation_service.dart';
import 'package:effective_mobile_test/theme/string_resources.dart';
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
            const Text(
              StringResource.DIFFICULT_ROUTE,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => locator<NavigationService>().goBack(),
              child: const Text(StringResource.GO_BACK),
            ),
          ],
        ),
      ),
    );
  }
}
