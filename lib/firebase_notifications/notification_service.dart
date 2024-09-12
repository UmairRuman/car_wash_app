import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/NotificationPage/view/notification_page.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:car_wash_app/Client/pages/profile_page/controller/profile_state_controller.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/Controllers/favourite_service__state_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//For background Notifications wwe have to maka a top level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message, WidgetRef ref) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  await Firebase.initializeApp();
  ref.read(bookingsIntialStateProvider.notifier).getAllInitialBookings;

  log("Handling a background message: ${message.notification!.title}");
}

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Let firstly Intiallize local notifications for our app
  Future<void> initLocalNotifications(
      RemoteMessage message, BuildContext context, WidgetRef ref) async {
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
        rediectMessageWhenAppOpen(message, context, ref);
      },
    );
  }

  //Show Local Notification
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "ID1",
      "Chnannel1",
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    var notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails);
  }
//Listening messages when the app is open

  Future<void> getMessageOnAppOnOpen(
      BuildContext context, WidgetRef ref) async {
    FirebaseMessaging.onMessage.listen(
      (message) {
        initLocalNotifications(message, context, ref);
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
  void rediectMessageWhenAppOpen(
      RemoteMessage message, BuildContext context, WidgetRef ref) async {
    if (message.data['story_id'] == 'story_12345') {
      log("entered");
      String carWashDateString = message.data['car_wash_date'];
      DateTime carWashDate = DateTime.parse(carWashDateString);
      log("Car wash date in redirect $carWashDate");
      ref.read(bookingStateProvider.notifier).dateTimeForFilter =
          DateTime(carWashDate.year, carWashDate.month, carWashDate.day);
      try {
        log("Navigating to the Admin Notification page ");
        Navigator.of(context).pushNamed(AdminSideNotificationPage.pageName);
        log("Getting Notifications");
        await ref
            .read(messageStateProvider.notifier)
            .getAllNotificationsByUserId();
        log("Getting Bookings");
        // await ref
        //     .read(bookingStateProvider.notifier)
        //     .getBookings(FirebaseAuth.instance.currentUser!.uid);
      } catch (e) {
        log("Error in redirect message Method : ${e.toString()}");
      }
    }
  }

  Future<void> redirectWhenAppInBgOrTermianted(
      BuildContext context, WidgetRef ref) async {
    // If the app is terminated
    RemoteMessage? intialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (intialMessage != null) {
      // Await all necessary data loading before navigation
      // await initializeAppData(ref);
      // await Future.delayed(const Duration(seconds: 5));
      // rediectMessageWhenAppOpen(intialMessage, context, ref);
    }

    // When the app is in the background state
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) async {
        // await initializeAppData(ref);
        // await Future.delayed(const Duration(seconds: 5));
        // rediectMessageWhenAppOpen(event, context, ref);
      },
    );
  }

// New function to handle app data initialization
  Future<void> initializeAppData(WidgetRef ref) async {
    try {
      await ref.read(profileDataStateProvider.notifier).getUserAllDData();
      await ref
          .read(previousServiceStateProvider.notifier)
          .getIntialListPreviousServices();
      await ref
          .read(allServiceDataStateProvider.notifier)
          .getIntialListOfServices();
      await ref
          .read(favouriteServiceProvider.notifier)
          .getAllIntialFavouriteServices();
      await ref.read(messageStateProvider.notifier).intialMessages();
      log("All data initialized successfully.");
    } catch (e) {
      log("Error initializing app data: ${e.toString()}");
    }
  }
}
