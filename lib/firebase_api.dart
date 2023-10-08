import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push/main.dart';

import 'MyNotification.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("title ${message.notification?.title}");
  print("body ${message.notification?.body}");
  print("data ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel ",
    "High Imoprtance Notification ",
    description: "the is used important Notification ",
    importance: Importance.defaultImportance,
  );

  void handelMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      MyNotification.route,
      arguments: message,
    );
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handelMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("this is the Token ${fCMToken}");
    initPushNotification();
  }
}
