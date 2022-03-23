import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gj_test/controller/tab_screen_controller.dart';
import 'package:gj_test/controller/test_screen_controller.dart';
import 'package:gj_test/gj_test.dart';
import 'package:gj_test/model/item_tab.dart';
import 'package:gj_test/screen/first_screen.dart';
import 'package:gj_test/screen/second_screen.dart';

class TabScreen extends StatelessWidget {
  final double heightTab = 70;
  var views = <Widget>[];
  var itemTabs = <ItemTab>[].obs;
  var titles = <String>[];
  var iconActives = <String>[];
  var iconNotActives = <String>[];
  var colorActive = Colors.red;
  var colorNotActive = Colors.black;
  var currentIndex = 0.obs;

  var tabScreenController = Get.put(TabScreenController());

  @override
  Widget build(BuildContext context) {
    // views
    //views.add(TestScreen());
    views.add(TestScreen());
    views.add(SecondScreen());

    // title
    titles.add('Tab 1');
    titles.add('Tab 2');

    // iconActive
    iconActives.add('');
    iconActives.add('');

    // iconNotActive
    iconNotActives.add('');
    iconNotActives.add('');

    itemTabs.add(ItemTab(title: titles[0], colorTitle: colorActive));
    itemTabs.add(ItemTab(title: titles[1], colorTitle: colorNotActive));

    return Obx(
      () => Scaffold(
        body: IndexedStack(index: currentIndex.value, children: views),
        bottomNavigationBar:
            _buildBottomTab(heightTab: heightTab, context: context),
      ),
    );
  }

  Widget _buildBottomTab(
      {required double heightTab, required BuildContext context}) {
    return Container(
      height: heightTab,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              flex: 50,
              child: _buildItemTab(
                  itemTab: itemTabs[0], context: context, index: 0)),
          Expanded(
              flex: 50,
              child: _buildItemTab(
                  itemTab: itemTabs[1], context: context, index: 1)),
        ],
      ),
    );
  }

  Widget _buildItemTab(
      {required ItemTab itemTab,
      required BuildContext context,
      required int index}) {
    return InkWell(
      onTap: () {
        tabScreenController.clickTab((dataTabCallback) {
          itemTabs.value = dataTabCallback.itemTabs;
          currentIndex.value = dataTabCallback.currentIndex;
        }, index, titles, iconActives, iconNotActives, colorActive,
            colorNotActive);
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Text(
          itemTab.title,
          style: TextStyle(color: itemTab.colorTitle),
        ),
      ),
    );
  }
}
