import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static bool initialized = false;

  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() {
    return _instance;
  }
  LocalNotificationService._internal();

  static Future<void> init() async {
    if (initialized) {
      return;
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.createNotificationChannel(
      const AndroidNotificationChannel(
        'reminder_notifications', // Same ID as in AndroidNotificationDetails
        'Reminder Notifications',
        description: 'Notifications that are scheduled to appear later',
        importance: Importance.max,
      ),
    );
    initialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
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

  static Future<List<PendingNotificationRequest>>
      getPendingNotifications() async {
    return await FlutterLocalNotificationsPlugin()
        .pendingNotificationRequests();
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
          channelDescription:
              'Notifications that are scheduled to appear later',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.time, // For daily at time
    );
  }

  static Future<void> scheduledNotificationAfter3seconds(
      int id, String title, String body) async {
    // Ask for notification permission (Android 13+)

    bool permissionGranted = await requestNotificationPermission();
    print("Permission: $permissionGranted");

    if (permissionGranted == false) {
      return;
    }
    await LocalNotificationService.flutterLocalNotificationsPlugin.show(
      1,
      'Test Notification',
      'This should appear immediately',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_notifications',
          'Reminder Notifications',
          channelDescription: 'Test notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
      final scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_notifications', // Must match channel ID
          'Reminder Notifications',
          channelDescription:
              'Test notifications that appear after a short delay',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
  static Future<bool> requestNotificationPermission() async {
    // Check notification permission status
    PermissionStatus status = await Permission.notification.status;

    if (status.isDenied) {
      // Request permission
      status = await Permission.notification.request();
    }

    if (status.isPermanentlyDenied) {
      // Optionally prompt user to enable manually
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }
}
