import 'package:flutter/material.dart';
import 'package:flutter_app/screen/splash_screen.dart';
import 'package:core/router/deeplink_constant.dart';
import 'package:gj_test/gj_test.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case DeeplinkConstant.testModule:
      return MaterialPageRoute(builder: (context) => TabScreen());
    case DeeplinkConstant.splashScreen:
      return MaterialPageRoute(builder: (context) => SplashScreen());

    default:
      return MaterialPageRoute(builder: (context) => TabScreen());
  }
}
