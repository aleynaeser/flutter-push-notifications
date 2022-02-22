import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'local_notification_api.dart';

class NotificationListenerProvider {
  final _firebaseMessaging = FirebaseMessaging.instance.getInitialMessage();

  void getMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      RemoteNotification notification = event.notification!;

      print(":::::::::: $notification");

      // AppleNotification apple = event.notification!.apple!;
      AndroidNotification androidNotification = event.notification!.android!;

      if (notification != null && androidNotification != null) {
        //Show local notification
        sendNotification(title: notification.title!, body: notification.body);

        //Show Alert dialog
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(notification.title!),
                content: Text(notification.body!),
              );
            });
      }
    });
  }
}
