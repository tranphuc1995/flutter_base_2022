import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
