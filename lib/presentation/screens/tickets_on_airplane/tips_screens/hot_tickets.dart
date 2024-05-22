import 'package:effective_mobile_test/app/service_locator.dart';
import 'package:effective_mobile_test/domain/navigator/navigation_service.dart';
import 'package:effective_mobile_test/theme/string_resources.dart';
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
            const Text(
              StringResource.HOT_TICKETS,
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
