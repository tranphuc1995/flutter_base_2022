class AppConst {
  //env
  static bool isDebug = true;
  static String domainProduction = 'https://api.themoviedb.org/3/movie';
  static String domainDev = 'https://api.themoviedb.org/3/movie';
  static String domainStaging = 'https://api.themoviedb.org/3/movie';

  //ui
  static const double kHeightButton = 48.0;
  static const double kPaddingDefault = 16.0;
  static const double kStatusBarHeight = 56.0;

  // key sharepreference
  static const String emptyString = '';
  static const String keyInitApp = 'initApp';
  static const String keyToken = 'token';
  static const String keyLanguage = 'token';
  static const String keyEnviroment = 'enviroment';

  //network
  static const String noneNetwork = 'none';

  //language
  static String vi = 'vi';
  static String en = 'en';

  //local notification
  static String channelName = 'channel_name';
  static String channelId = 'channel_id';
  static String channelDescription = 'channel_description';
}
