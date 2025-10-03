import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      bool initialized = false;

  static final LocalNotificationService _instance = LocalNotificationService._internal();
  factory LocalNotificationService() {
    return _instance;
  }
  LocalNotificationService._internal();
  
 Future<void> init() async {
  if(initialized)
  {
    return;
  }
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  initialized = true;

 }

 Future<void> showNotification(RemoteMessage message) async{
  await init();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'call_notifications',
    'Call Notifications',
    channelDescription: 'General push notifications from the top',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? 'No Title',
    message.notification?.body ?? 'No Body',
    platformChannelSpecifics,
    payload: 'item x',
  );
 }

 static Future<void> cancelAllNotifications() async {
  await FlutterLocalNotificationsPlugin().cancelAll();
 }

 static Future<void> cancelNotification(int id) async {
  await FlutterLocalNotificationsPlugin().cancel(id);
 }
 static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
  return await FlutterLocalNotificationsPlugin().pendingNotificationRequests();
 }


}