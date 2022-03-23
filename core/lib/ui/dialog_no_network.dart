import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core/ui/gj_button.dart';

void showDialogNoInternet() {
  Get.defaultDialog(
      backgroundColor: Colors.white,
      radius: 10,
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            child: GjButton(
              text: 'Back',
              isActive: true,
              press: () {},
            ),
          ),
        ],
      ));
}
