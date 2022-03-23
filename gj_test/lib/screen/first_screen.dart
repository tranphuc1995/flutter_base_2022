import 'package:core/ui/gj_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gj_test/model/test_data.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments as TestData;
    return Scaffold(
      body: Center(
          child: Column(children: [
        Text('First Screen with data ${data.dataDemo}'),
        GjButton(
          text: 'Send Data Back',
          isActive: true,
          press: () {
            Get.back(result: 'xxx');
          },
        )
      ])),
    );
  }
}
