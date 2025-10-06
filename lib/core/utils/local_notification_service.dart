import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {

 static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
    static  bool initialized = false;

  static final LocalNotificationService _instance = LocalNotificationService._internal();
  factory LocalNotificationService() {
    return _instance;
  }
  LocalNotificationService._internal();
  
static Future<void> init() async {
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
 static Future<void> scheduleNotification(
    int id, String title, String body, DateTime scheduledDate) async {

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    tz.TZDateTime.from(scheduledDate, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_notifications',
        'Reminder Notifications',
        channelDescription: 'Notifications that are scheduled to appear later',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    matchDateTimeComponents: DateTimeComponents.time, // For daily at time
  );

 }
static  Future<void> scheduledNotificationAfter3seconds(
    int id, String title, String body) async {
      
     final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    // Ask for notification permission (Android 13+)
 
 bool? permissionRequest= await androidImplementation?.requestNotificationsPermission();
 print("Permission: $permissionRequest");
 if(permissionRequest==false)
 {  
    return;
  }
    
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_notifications',
        'Reminder Notifications after ',
        channelDescription: 'Notifications that are scheduled to appear later',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
 }

}