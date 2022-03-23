import 'package:flutter/material.dart';
import 'package:flutter_app/di/di_application.dart';
import 'package:flutter_app/generate_route.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:core/router/deeplink_constant.dart';
import 'package:core/router/navigation_service.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //di application
  buildApplicationDI();

  runApp(Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
      initialRoute: DeeplinkConstant.splashScreen,
      navigatorKey: GetIt.instance<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
    
    );
  }));
}
