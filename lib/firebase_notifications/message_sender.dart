import 'dart:convert';
import 'dart:developer';

import 'package:car_wash_app/firebase_notifications/get_server_key.dart';
import 'package:car_wash_app/firebase_notifications/notification_service.dart';
import 'package:http/http.dart';

class MessageSender {
  GetServiceKey getServiceKey = GetServiceKey();
  NotificationServices notificationServices = NotificationServices();
  String url =
      "https://fcm.googleapis.com/v1/projects/car-wash-app-86a16/messages:send";

  // var data = {
  //    "to": "$acces",
  //   "notification": {
  //     "title": "Breaking News",
  //     "body": "New news story available."
  //   },
  //   "data": {"story_id": "story_12345"}
  // };

  void sendMessage(String token, {Map<String, String>? data}) async {
    try {
      var accessToken = await getServiceKey.getServiceKeyTokken();

      log("Device Token: $token");
      log("Access Token: $accessToken");

      var response = await post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': {
            'token': token, //This is the token whom to send notification
            'notification': {
              'title': 'Breaking News',
              'body': 'New Booking available.',
            },
            'data': {
              'story_id': 'story_12345',
              if (data != null) ...data,
            },
          },
        }),
      );

      log('FCM Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        log('Notification sent successfully');
      } else {
        log('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      log('Error sending message: $e');
    }
  }
}
