import 'dart:ui';

import 'package:status_bar_control/status_bar_control.dart';

class StatusBarHandler {
  static Future<double> getHeightStatusBar() async {
    var statusBarHeight = await StatusBarControl.getHeight;
    return statusBarHeight;
  }

  static Future<void> setStatusBarColor(Color color) async {
    await StatusBarControl.setColor(color, animated: true);
  }
}
