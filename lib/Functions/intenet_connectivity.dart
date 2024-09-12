import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_device_token_collectiion.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void checkAndUpdateToken() async {
  UserCollection userCollection = UserCollection();
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  AdminDeviceTokenCollection adminDeviceTokenCollection =
      AdminDeviceTokenCollection();
  if (FirebaseAuth.instance.currentUser != null) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    if (await hasInternetConnection()) {
      var isAdmin = await userCollection.getUserInfo(userId);
      final messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();

      if (token != null && isAdmin) {
        var adminDeviceToken =
            await adminDeviceTokenCollection.getSpecificDeviceToken(userId);
        if (adminDeviceToken.deviceToken != "" &&
            adminDeviceToken.deviceToken != token) {
          await adminDeviceTokenCollection.updateAdminDeviceToken(
              token, userId);
          await userCollection.updateUserDeviceToken(userId, token);
          await adminInfoCollection.updateAdminDeviceToken(userId, token);
        }
        // Proceed with updating the token
      }
    } else {
      Fluttertoast.showToast(
          msg: "No internet Access.Some app features may cause issue.",
          toastLength: Toast.LENGTH_LONG);
    }
  }
}

Future<bool> hasInternetConnection() async {
  // Check if the device is connected to any network (WiFi or mobile)
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult[0] == ConnectivityResult.none) {
    return false; // Not connected to any network
  }

  // Attempt to make an HTTP request to a reliable server
  try {
    final result = await http.get(Uri.parse('https://www.google.com')).timeout(
          const Duration(seconds: 5),
        );
    if (result.statusCode == 200) {
      return true; // Connected to the internet
    } else {
      return false; // Connected to a network but no internet access
    }
  } catch (e) {
    return false; // Error occurred (likely no internet access)
  }
}
