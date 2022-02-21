import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_notifications/page/notification_page.dart';
import '../constant/notification_api.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void _increaseCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotificaition);
  }

  void onClickedNotificaition(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NotificationPage(payload: payload)));
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
            Text(
              'Local Notifications',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      _increaseCounter();
                      NotificationApi.showNotification(
                          title: 'Counter Notification',
                          body: 'The number is increased.',
                          payload: 'counter.not');
                    },
                    child: const Icon(
                      Icons.add_box_rounded,
                      color: Colors.indigoAccent,
                      size: 50,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      _decreaseCounter();
                      NotificationApi.showScheduledNotification(
                          title: 'Counter Scheduled Notification',
                          body: 'The number is decreased.',
                          payload: 'decrease_5pm',
                          scheduledDate:
                              DateTime.now().add(Duration(seconds: 10)));
                      const snackBar = SnackBar(
                        content: Text(
                          'Scheduled in 10 seconds!',
                          style: TextStyle(fontSize: 24),
                        ),
                        backgroundColor: Colors.indigoAccent,
                      );
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                    child: const Icon(Icons.indeterminate_check_box,
                        color: Colors.indigoAccent, size: 50)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
