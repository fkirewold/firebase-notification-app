import 'package:firebase_notification_app/core/utils/firebase_messaging.dart';
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
    FirebaseMsg().initFirebaseMessaging(context);
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
      ),
      body: Center(
        child: Text("Firebase Push Notification App"),
    ));
  }
}