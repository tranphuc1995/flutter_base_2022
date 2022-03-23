import 'dart:developer';

import 'package:core/gj_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationHandler {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> showNotification(
      int id, String title, String body, String payload) async {
    await _notification.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }

  static Future<void> cancelAllNotification() async {
    await _notification.cancelAll();
  }

  static Future<void> initLocalNotification() async {
    var initSettingAndroid =
        const AndroidInitializationSettings('@drawable/ic_local_noti_demo');
    var initSettingIos = const IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    var initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIos);
    await _notification.initialize(initSetting,
        onSelectNotification: (payload) {
      if (payload == 'second_screen') {
        log('debug_phuc');
      }
    });
  }

  static Future<NotificationDetails> _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            AppConst.channelId, AppConst.channelName,
            channelDescription: AppConst.channelDescription,
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_local_noti_demo'),
        iOS: const IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true));
  }
}
