import 'package:flutter/foundation.dart';
import 'package:core/const/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnviromentHandler {
  static Future<String> getBaseUrl() async {
    var prefs = await SharedPreferences.getInstance();
    var defaultDomain =
        AppConst.isDebug ? AppConst.domainDev : AppConst.domainProduction;
    var baseUrl = prefs.getString(AppConst.keyEnviroment) ?? defaultDomain;
    return baseUrl;
  }
}
