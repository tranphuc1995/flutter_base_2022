import 'package:core/color/app_color.dart';
import 'package:core/gj_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  Future<void> initApp(ValueSetter<String> callBack) async {
    var prefs = await SharedPreferences.getInstance();
    var init = prefs.getBool(AppConst.keyInitApp) ?? false;
    if (!init) {
      await GetIt.instance
          .get<FlutterSecureStorage>()
          .write(key: AppConst.keyToken, value: AppConst.emptyString);

      await prefs.setBool(AppConst.keyInitApp, true);
    }
    StatusBarHandler.setStatusBarColor(AppColor.primary);
    AppConfig.heightStatusBar = await StatusBarHandler.getHeightStatusBar();
    AppConfig.currentEnviroment = await EnviromentHandler.getBaseUrl();
    AppConfig.currentLanguage = await LanguageHandler.getCurrentLanguage();
    await LocalNotificationHandler.initLocalNotification();
    var payload = await initFirebase();
    callBack(payload);
  }
}
