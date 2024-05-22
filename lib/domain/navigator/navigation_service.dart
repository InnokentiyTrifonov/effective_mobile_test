import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  void pushTo(String route, {Object? arguments}) {
    navigationKey.currentState?.pushNamed(route, arguments: arguments);
  }

  void goBack() {
    navigationKey.currentState?.pop();
  }

  bool canPop() {
    if (navigationKey.currentState != null) {
      return navigationKey.currentState!.canPop();
    } else {
      return false;
    }
  }
}
