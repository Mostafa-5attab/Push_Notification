import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyNotification extends StatelessWidget {
  const MyNotification({super.key});
  static const route = "/MyNotification";

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
            "${(message as RemoteMessage).notification?.title ?? 'No Title'}"),
      ),
    );
  }
}
