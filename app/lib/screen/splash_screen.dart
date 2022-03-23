import 'package:flutter/material.dart';
import 'package:flutter_app/controller/splash_screen_controller.dart';
import 'package:get/get.dart';
import 'package:gj_test/screen/tab_screen.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  var splashScreenController = Get.put(SplashScreenController());
  var payload = 'xxxxxx'.obs;

  SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    splashScreenController.initApp((value) {
      //Get.to(() => TabScreen());
      payload.value = value;
    });
    return Scaffold(
      body: Center(
        child: Obx(() => Text(payload.value)),
      ),
    );
  }
}
