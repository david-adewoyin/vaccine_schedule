import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vaccine_scheduler/models/child_model.dart';
import 'package:vaccine_scheduler/models/vaccine_model.dart';
import 'package:vaccine_scheduler/services/notifciation_service.dart';

// ignore: constant_identifier_names
const String channel_id = "123";

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  _scheduleInDays(ChildModel child, int days, String text) async {
    tz.initializeTimeZones();
    var dob = child.dob;
    // get t= dob - today;
    var t = tz.TZDateTime.now(tz.local).difference(dob).inDays;
    // get to = days -t; return actual day to run notification
    var to = days - t;
    var date = tz.TZDateTime.now(tz.local).add(Duration(days: to));
    print(date);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      child.id + days,
      'Vaccine Scheduler',
      text,
      date,
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.max,
      )),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    /*    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      enableLights: false,
      enableVibration: false,
      importance: Importance.high,
      priority: Priority.max,
      channelDescription: 'repeating description',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
      child.id + days,
      'Vaccine Scheduler',
      text,
      RepeatInterval.daily,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    ); */
  }

  scheduleNotification(ChildModel child) async {
    _scheduleInDays(child, 1,
        "${child.name} hasn't completed the vaccines meant to be taken at birth");
    _scheduleInDays(child, 42,
        "${child.name} hasn't completed the vaccines meant for 6th week");
    _scheduleInDays(child, 70,
        "${child.name} hasn't haven't completed the vaccines meant for the 10th week");
    _scheduleInDays(child, 98,
        "${child.name} hasn't haven't completed the vaccines meant for 14th week");
    _scheduleInDays(child, 183,
        "${child.name} hasn't completed the vaccines meant for the 6th month");
    _scheduleInDays(child, 274,
        "${child.name} hasn't completed the vaccines meant for the 9th month");
    _scheduleInDays(child, 456,
        "${child.name} hasn't completed the vaccines meant for the 15th month");
  }

  rescheduleNotification(ChildModel child, VaccineModel vaccine) {
    switch (vaccine.daysPeriodBeforeNotification) {
      case 1:
        _scheduleInDays(child, 1,
            "${child.name} hasn't completed the vaccines meant to be taken at birth");
        break;
      case 42:
        _scheduleInDays(child, 42,
            "${child.name} hasn't completed the vaccines meant for 6th week");
        break;
      case 70:
        _scheduleInDays(child, 70,
            "${child.name} hasn't haven't completed the vaccines meant for the 10th week");
        break;
      case 98:
        _scheduleInDays(child, 98,
            "${child.name} hasn't haven't completed the vaccines meant for 14th week");
        break;
      case 183:
        _scheduleInDays(child, 183,
            "${child.name} hasn't completed the vaccines meant for the 6th month");
        break;
      case 274:
        _scheduleInDays(child, 274,
            "${child.name} hasn't completed the vaccines meant for the 9th month");
        break;
      case 456:
        _scheduleInDays(child, 456,
            "${child.name} hasn't completed the vaccines meant for the 15th month");
        break;
      default:
    }
  }

  retrievePendingNotification() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  removeNotification(VaccineModel model) async {
    // cancel the notification with id value of zero
    int id = model.childId! + model.daysPeriodBeforeNotification;
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  selectNotification(String? payload) async {
    print(payload);
  }
}
