import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifications/constant/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future init({bool initScheduled = false}) async {

    final iOS = IOSInitializationSettings();
    final andorid = AndroidInitializationSettings('mipmap/ic_launcher');
    final settings = InitializationSettings(android: andorid, iOS: iOS);

    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future _notificationDetails() async {
    final bigPicturePath = await Utils.downloadFile(
        'https://cdn1.vectorstock.com/i/1000x1000/39/25/dollar-increase-decrease-icon-money-symbol-vector-21203925.jpg ',
        'bigPicture');
    final largeIconPath = await Utils.downloadFile(
        'https://previews.123rf.com/images/chanut/chanut1808/chanut180802043/107443743-erh%C3%B6hen-sie-den-pfeil-und-verringern-sie-die-pfeilvektorillustration-im-flachen-farbdesign.jpg',
        'largeIcon');

    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id 3',
        'channel name',
        importance: Importance.max,
        //playsound:false;
        styleInformation: styleInformation,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  static void cancel(int id) => _notifications.cancel(id);

  static void cancelAll() => _notifications.cancelAll();
}
