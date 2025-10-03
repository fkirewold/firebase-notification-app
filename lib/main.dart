import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notification_app/core/utils/firebase_messaging.dart';
import 'package:firebase_notification_app/firebase_options.dart';
import 'package:firebase_notification_app/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:firebase_notification_app/core/utils/local_notification_service.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(FirebaseMsg.firebaseMessagingBackgroundHandler);
  // 1. Initialize the timezone database
  tz.initializeTimeZones();
  // 2. Get the device's local timezone
final TimezoneInfo currentTimeZone = await FlutterTimezone.getLocalTimezone();  // 3. Set the local timezone for timezone package
  tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
    await LocalNotificationService.init();

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