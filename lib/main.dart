import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push/firebase_api.dart';
import 'package:push/firebase_options.dart';
import 'HomeScreen.dart';
import 'MyNotification.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: HomeScreen(),
      routes: {MyNotification.route: (context) => const MyNotification()},
    );
  }
}
