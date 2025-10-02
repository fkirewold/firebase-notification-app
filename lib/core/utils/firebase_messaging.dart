import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMsg {
 static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message: ${message.notification?.title}');
}
final FirebaseMessaging _messaging = FirebaseMessaging.instance;

void requestPermission() async {
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined permission');
    return ;
  }
}
void initFirebaseMessaging(context)  async{
  requestPermission();
  await  _messaging.subscribeToTopic("allUsers").then((_) async{
    print("Subscribed to allUsers topic");
    String? token= await _messaging.getToken();
    print("Firebase Messaging Token: $token");
  });

FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  if (message.notification != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${message.notification!.title}: ${message.notification!.body}"),
      ),
    );
  }
});


  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
     if (message.notification != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${message.notification!.title}: ${message.notification!.body}"),
      ),
    );
  }
});

}
}