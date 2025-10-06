//import 'package:firebase_notification_app/core/utils/firebase_messaging.dart';
import 'package:firebase_notification_app/core/utils/local_notification_service.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

@override
  void initState() {
    super.initState();
   // FirebaseMsg().initFirebaseMessaging(context);
  }
@override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Push Notification"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(                
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              onPressed: ()async{
                
                await LocalNotificationService.scheduledNotificationAfter3seconds(3, '3 Second', "This is a test notification after 3 seconds",);
              },
             child: Text("Notification after 3 seconds",style: TextStyle(color: Colors.white),)),
           ],
        ),

    ));
  }
}