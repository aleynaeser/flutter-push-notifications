# Flutter Push Notifications

This repo is a tutorial for local and firebase notifications in flutter.

## 1. Local Notifications
 
 <table>
   <tbody>
      <tr>
         <td><img src="https://user-images.githubusercontent.com/45822686/154970235-cdb38bca-22ff-4a2f-a469-fc8ea56b7077.png" height=300pm></td>
         <td><img src="https://user-images.githubusercontent.com/45822686/154970248-854f15da-c605-4b09-a81b-102c7196a6d9.png" height=300pm></td>
         <td><img src="https://user-images.githubusercontent.com/45822686/154970255-2fa83fae-0d2d-4c41-a330-815dcd586768.png"height=300pm></td>
      </tr>
         <tr>
         <td><img src="https://user-images.githubusercontent.com/45822686/154970282-f24a537c-feb0-4b7b-b03c-b5dde883ec63.png" height=300pm></td>
         <td><img src="https://user-images.githubusercontent.com/45822686/154970303-e35ab02b-f3d6-4b4a-b221-110d668bc72d.png" height=300pm></td>
         <td><img src="https://user-images.githubusercontent.com/45822686/154970310-94eafdb9-0313-4be4-b084-4f4e6e179d12.png"height=300pm></td>
      </tr>
   </tbody>
</table>


#### For Daily Notification: 

```
      _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduleDaily(Time(8)), // 8am morning daily
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
     matchDateTimeComponents: DateTimeComponents.time,
      );
  
  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.year,
      time.hour,
      time.minute,
      time.second,
    );
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days:1))
        : scheduledDate;
  }
  ```

#### For Weekly Notification: 

  ``` _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduleWeekly(Time(8), days: [DateTime.monday, DateTime.tuesday]),
        // weekly 8am morning
        // _scheduleDaily(Time(8)), // 8am morning daily
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // matchDateTimeComponents: DateTimeComponents.time,
      );

  //  Daily Notification for next morning
  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.year,
      time.hour,
      time.minute,
      time.second,
    );
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }

  // Weekly Notification for next tuesday
  static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduleDaily(time);

    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }

  ```

#### Packages in use:

* flutter_svg: ^1.0.3
* flutter_local_notifications: ^9.3.2
* rxdart: ^0.27.3
* timezone: ^0.8.0
* flutter_native_timezone: ^2.0.0
* path_provider: ^2.0.9
* http: ^0.13.4

<hr> </hr>


## 1. Firebase (FCM) Notifications
  
 <table>
   <tbody> 
   <tr>
         <td><img src="https://user-images.githubusercontent.com/45822686/155171316-680d1ef4-5004-49f9-9bce-249ac09b9aee.png" height=200pm></td>
         <td><img src="https://user-images.githubusercontent.com/45822686/155171450-200ea41e-31d1-4b32-b6ac-d0e457e7f29e.png" height=300pm></td>
         <td><img src="https://user-images.githubusercontent.com/45822686/155171469-8d8e0d1a-4c08-41e1-93f4-6119a7ec2cd8.png"height=300pm></td>
      </tr>

   </tbody>
</table>


#### Packages in use:

* flutter_svg: ^1.0.3
* flutter_local_notifications: ^9.3.2
* firebase_core: ^1.12.0
* firebase_messaging: ^11.2.6

<hr> </hr>



## To use this app follow below instructions :
#### Clone this app using below syntax:

``` git clone https://github.com/Aleynaesr/flutter-push-notifications.git```

* After cloning install packages using below syntax:

``` flutter pub get ```

* Above command will install all the necessary packages.

* Add below codes to AndroidManifest.xml

```
  android:showWhenLocked="true"
  android:turnScreenOn="true" 
```

* Add below codes to AppDelegate.swift
```
   if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
```
* Run the app on your mobile emulator using below command:

``` flutter run ```

Thank you happy coding  🎈
