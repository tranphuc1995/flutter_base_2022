import 'dart:developer';

import 'package:core/gj_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<String> initFirebase() async {
  // use for handle background notification.
  var deeplink = '';

  // init firebase core.
  await Firebase.initializeApp();

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 60),
    minimumFetchInterval: const Duration(milliseconds: 2),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final notificationAppLaunchDetails =
      await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    deeplink = notificationAppLaunchDetails!.payload ?? '';
  }

  // callback to get Token Firebase
  await FirebaseMessaging.instance.getToken().then((token) {
    log('token firebase: $token');
  });

  // callback when app open and have incoming notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotificationHandler.showNotification(0, 'aaaa',
        'bbbbb', 'ccccc');
  });
  return deeplink;
}

// callback handle notification when app in background.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await  LocalNotificationHandler.showNotification(0, 'aaaa',
        'bbbbb', 'second_screen');
}
