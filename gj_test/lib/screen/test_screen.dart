
import 'package:core/gj_core.dart';
import 'package:flutter/material.dart';
import 'package:gj_test/controller/test_screen_controller.dart';
import 'package:get/get.dart';
import 'package:gj_test/model/test_data.dart';

import 'first_screen.dart';

// ignore: must_be_immutable
class TestScreen extends StatelessWidget {
  var data = TestData(dataDemo: '').obs;
  var dataFromFirstScreen = ''.obs;
  var testScreenController = Get.put(TestScreenController());
  TestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppBar(
              title: 'xxxxx',
            ),
            Padding(
              padding: EdgeInsets.all(AppConst.kPaddingDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GjButton(
                    text: LanguageData.data[LanguageKey().getData] ?? '',
                    isActive: true,
                    press: () {
                      testScreenController.getData((value) {
                        data.value = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  GjButton(
                    text: 'Show Dialog',
                    isActive: true,
                    press: () {
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
                                  press: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                  const SizedBox(height: 16),
                  GjButton(
                    text: 'Show Modal Bottom Sheet',
                    isActive: true,
                    press: () {
                      Get.bottomSheet(
                          Container(
                            height: 236,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                GjButton(text: 'Button1'),
                                const SizedBox(
                                  height: 16,
                                ),
                                GjButton(text: 'Button2'),
                                const SizedBox(
                                  height: 16,
                                ),
                                GjButton(text: 'Button3'),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16))));
                    },
                  ),
                  const SizedBox(height: 16),
                  GjButton(
                    text: 'Move First Screen',
                    isActive: true,
                    press: () async {
                      var data = await Get.to(() => FirstScreen(),
                          arguments: TestData(dataDemo: 'xxxx'));
                      dataFromFirstScreen.value = data;
                    },
                  ),
                  const SizedBox(height: 16),
                  GjButton(
                    text: 'Show Notification',
                    isActive: true,
                    press: () async {
                      await LocalNotificationHandler.showNotification(
                          0, 'title', 'body', 'second_screen');
                    },
                  ),
                  Obx(
                    () => Text(
                      dataFromFirstScreen.value,
                      style: FontUtils.getAppFont(
                          fontSize: 14,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Obx(
                    () => Text(
                      data.value.dataDemo,
                      style: FontUtils.getAppFont(
                          fontSize: 14,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
