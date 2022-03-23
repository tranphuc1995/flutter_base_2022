import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:core/const/app_const.dart';

Future<bool> checkInterAvailable() async {
  var _connectivity = Connectivity();
  var hasInternet = false;
  try {
    var result = await _connectivity.checkConnectivity();
    if (result.name == AppConst.noneNetwork) {
      hasInternet = false;
    } else {
      hasInternet = true;
    }
  } on PlatformException catch (e) {}
  return hasInternet;
}
