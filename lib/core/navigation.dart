import 'package:flutter/material.dart';

abstract class Navigation {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static void pushTo(String route, {Object? arguments}) =>
      navigationKey.currentState?.pushNamed(route, arguments: arguments);

  static void goBack() => navigationKey.currentState?.pop();

  static bool canPop() => navigationKey.currentState != null
      ? navigationKey.currentState!.canPop()
      : false;
}
