import 'package:core/const/app_config.dart';
import 'package:core/const/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageHandler {
  static Future<String> getCurrentLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConst.keyLanguage) ?? AppConst.vi;
  }

  static Future<void> changeLanguage({required String language}) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConst.keyLanguage, language);
    AppConfig.currentLanguage = language;
  }
}
