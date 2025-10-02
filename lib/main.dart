import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notification_app/core/utils/firebase_messaging.dart';
import 'package:firebase_notification_app/firebase_options.dart';
import 'package:firebase_notification_app/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(FirebaseMsg.firebaseMessagingBackgroundHandler);

  runApp(FirebasePushNotificationApp());
}
class FirebasePushNotificationApp extends StatelessWidget {
  const FirebasePushNotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Firebase Push Notification",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationPage()
    );
  }
}