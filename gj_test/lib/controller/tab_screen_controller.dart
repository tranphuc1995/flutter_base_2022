import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gj_test/model/data_tab_callback.dart';
import 'package:gj_test/model/item_tab.dart';

class TabScreenController extends GetxController {
  void clickTab(
      ValueSetter<DataTabCallBack> callBack,
      int index,
      List<String> titles,
      List<String> iconActives,
      List<String> iconNotActives,
      Color colorActive,
      Color colorNotActive) {
    var result = <ItemTab>[];
    for (var i = 0; i < titles.length; i++) {
      var title = titles[i];
      var colorTitle = Colors.white;
      var icon = '';
      if (i == index) {
        colorTitle = colorActive;
        icon = iconActives[i];
      } else {
        colorTitle = colorNotActive;
        icon = iconNotActives[i];
      }
      var itemTab = ItemTab(title: title, colorTitle: colorTitle, icon: icon);
      result.add(itemTab);
    }
    callBack(DataTabCallBack(
      itemTabs: result,
      currentIndex: index,
    ));
  }
}
