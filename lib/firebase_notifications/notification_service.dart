import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/view/booking_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//For background Notifications wwe have to maka a top level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  log("Handling a background message: ${message.notification!.title}");
}

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Let firstly Intiallize local notifications for our app
  Future<void> initLocalNotifications(
      RemoteMessage message, BuildContext context) async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        log("Notification received");
        rediectMessageWhenAppOpen(message, context);
      },
    );
  }

  //Show Local Notification
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("ID1", "Chnannel1",
            importance: Importance.high,
            enableVibration: true,
            playSound: true,
            actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            '1',
            'Ok',
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            '2',
            'Cancel ',
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            '3',
            'Done',
            showsUserInterface: true,
          ),
        ]);

    var notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails);
  }
//Listening messages when the app is open

  Future<void> getMessageOnAppOnOpen(BuildContext context) async {
    FirebaseMessaging.onMessage.listen(
      (message) {
        initLocalNotifications(message, context);
        showNotification(message);
      },
    );
  }

  //Request permission
  Future<void> requestPermission() async {
    final notificationSettings = await messaging.requestPermission(
        provisional: true, alert: true, sound: true, announcement: true);

    await messaging.setAutoInitEnabled(true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      log("User give permission");
    } else {
      log("User denied permission");
    }
  }

  //Get Tokken
  Future<String> getTokken() async {
    final token = await messaging.getToken();
    if (token != null) {
      log(token);
    }
    return token!;
  }

//Get Latest token
  void getLatestToken() {
    messaging.onTokenRefresh.listen(
      (event) {
        log(event);
      },
    );
  }

  //We are using this function to redirect our user to screeen we want
  void rediectMessageWhenAppOpen(RemoteMessage message, BuildContext context) {
    if (message.data['story_id'] == 'story_12345') {
      log("entered");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const AdminSideBookingPage();
        },
      ));
    }
  }

  Future<void> redirectWhenAppInBgOrTermianted(BuildContext context) async {
    //If the app is terminated
    RemoteMessage? intialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (intialMessage != null) {
      rediectMessageWhenAppOpen(intialMessage, context);
    }

    //When the app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) {
        rediectMessageWhenAppOpen(event, context);
      },
    );
  }
}
