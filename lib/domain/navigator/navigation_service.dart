import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  dynamic pushTo(String route, {Object? arguments}) {
    return navigationKey.currentState?.pushNamed(route, arguments: arguments);
  }

  dynamic goBack() {
    return navigationKey.currentState?.pop();
  }
}
