
import 'dart:math';

import 'package:en_notes/common/constant.dart';
import 'package:en_notes/repository/data_repsitory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppSession {
  static AppSession _instance;

  AppSession._internal();

  static AppSession get() {
    if (_instance == null) {
      _instance = AppSession._internal();
    }
    return _instance;
  }

  Future scheduleNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // cancel all first
    await flutterLocalNotificationsPlugin.cancelAll();

    final userDataResponse = DataRepository.getInstance().usersDataResponse;
    if ((userDataResponse?.words?.length ?? 0) > 0) {
      final indexes = _randomIndexes(Constant.count_of_notify, (userDataResponse?.words?.length ?? 0) - 1);
      int counter = 0;
      indexes.forEach((element) async {
        counter++;
        final word = userDataResponse.words[element];
        var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: counter * Constant.duration_notify_second));
        print('time: ${scheduledNotificationDateTime.toString()}');
        var androidPlatformChannelSpecifics = AndroidNotificationDetails('$counter', 'name_$counter', 'desc_$counter');
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        NotificationDetails platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.schedule(
            counter,
            '${word.key}',
            '${word.value}',
            scheduledNotificationDateTime,
            platformChannelSpecifics);
      });
    }
  }

  List<int> _randomIndexes(int n, int max) {
    List<int> results = List();
    for (int i = 0; i < n; i++) {
      int r = i;
      if (r > max) {
        r = r % max;
      }
      //print('r = $r');
      results.add(r);
    }
    return results;
  }

  Future stopAllNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}