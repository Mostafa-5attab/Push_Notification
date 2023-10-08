import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // Function to display a notification
  void showNotification(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data;

    // Create a Flutter local notification
    // You can use a package like 'flutter_local_notifications' to display local notifications
    // In this example, we'll just print the notification details
    print("Notification Title: ${notification?.title}");
    print("Notification Body: ${notification?.body}");
    print("Notification Data: $data");
  }

  @override
  void initState() {
    super.initState();

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the message data or display a notification
      showNotification(message);
    });
    // Handle messages when the app is in the background but opened from a terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle the message data or navigate to a specific screen
      // In this example, we'll just print the message data
      print("onMessageOpenedApp: ${message.data}");
    });
    // Handle messages when the app is in the background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Get the device token for this instance of the app
    _firebaseMessaging.getToken().then((token) {
      print("Firebase Token: $token");
    });
  }

  // Background message handler
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Initialize Firebase if necessary
    await Firebase.initializeApp();

    // Handle the background message data
    print("Handling a background message: ${message.data}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text("khattab"),
          )
        ],
      ),
    );
  }
}
