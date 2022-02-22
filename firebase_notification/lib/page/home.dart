import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/utils/firebase_provider.dart';
import 'package:firebase_notification/utils/local_notification_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    NotificationListenerProvider().getMessage(context);
    getToken();
  }

  void _increaseCounter() {
    setState(() {
      _counter++;
    });
  }

  void getToken() async {
    final token = await _firebaseMessaging.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text(
              'Firebase Notifications',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              'assets/image.svg',
              width: 500,
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  _increaseCounter();
                  // Local notification when click button
                  sendNotification(
                      title: "Counter App", body: "The number is increased!");
                },
                child: const Icon(Icons.add_box_rounded,
                    color: Colors.indigoAccent, size: 50)),
          ],
        ),
      ),
    );
  }
}
