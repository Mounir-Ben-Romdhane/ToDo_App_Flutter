
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';

import '../models/task.dart';

class NotifyHelper {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject =
  BehaviorSubject<String>();

  initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    //tz.setLocalLocation(tz.getLocation(timeZoneName));
    final AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('reminders');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            debugPrint('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload!);
        },
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  displayNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  cancelNotification(Task task) async
  {
    await flutterLocalNotificationsPlugin.cancel(task.id!);
    print('cancelNotification');
  }

  cancelAllNotification() async
  {
    await flutterLocalNotificationsPlugin.cancelAll();
    print('cancelAllNotification');
  }

  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,
        task.title,
        task.note,
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        _nextInstanceOfTenAM(hour, minutes, task.remind! , task.repeat! , task.date!),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );

  }


  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes, int remind , String repeat, String date) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    var formattedDate = DateFormat.yMd().parse(date);
    final tz.TZDateTime fd = tz.TZDateTime.from(formattedDate, tz.local);

    tz.TZDateTime scheduledDate2 = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, formattedDate.year, formattedDate.month, formattedDate.day, hour, minutes);

    print('scheduledDate = $scheduledDate');
    print('scheduledDate2 = $scheduledDate2');

    if(remind == 5)
    {
      scheduledDate = scheduledDate.subtract(const Duration(hours: 1 ,minutes: 5));
    }

    if(remind == 10)
    {
      scheduledDate = scheduledDate.subtract(const Duration(hours: 1 ,minutes: 10));
    }

    if(remind == 15)
    {
      scheduledDate = scheduledDate.subtract(const Duration(hours: 1 ,minutes: 15));
    }

    if(remind == 20)
    {
      scheduledDate = scheduledDate.subtract(const Duration(hours: 1 ,minutes: 20));
    }
    if (scheduledDate.isBefore(now)) {
      if(repeat== 'Daily'){
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, (formattedDate.day)+1, hour, minutes);
      }
      if(repeat== 'Weekly'){
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, (formattedDate.day)+7, hour, minutes);
      }
      if(repeat== 'Monthly'){
        scheduledDate = tz.TZDateTime(tz.local, now.year, (formattedDate.month)+1, formattedDate.day, hour, minutes);
      }

      if(remind == 5)
      {
        scheduledDate = scheduledDate.subtract(const Duration(hours: 1 ,minutes: 5));
      }

      if(remind == 10)
      {
        scheduledDate = scheduledDate.subtract(const Duration(hours: 1 ,minutes: 10));
      }

      if(remind == 15)
      {
        scheduledDate = scheduledDate.subtract(const Duration(hours: 1 ,minutes: 15));
      }

      if(remind == 20)
      {
        scheduledDate = scheduledDate.subtract(const Duration(hours: 1 ,minutes: 20));
      }

    }

    print('next scheduledDate = $scheduledDate');

    return scheduledDate;
  }


  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('My payload is ' + payload);
      await Get.to(NotificationScreen(payload: payload.toString()));
    });
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

    void onDidReceiveLocalNotification(int id, String? title, String? body,
        String? payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      Get.dialog(Text(body!));
    }

  }

