import 'dart:developer';

import 'package:car_wash_app/Client/pages/chooser_page/controller/location_notifier.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/Functions/geo_locator.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';

class BtnAddLocationChooserPage extends ConsumerWidget {
  const BtnAddLocationChooserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void coordinatesIntoLocation() async {
      const int maxRetries = 3;
      int retryCount = 0;
      bool success = false;
      informerDialog(context, "Getting location");

      while (retryCount < maxRetries && !success) {
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              currentUserPosition!.latitude, currentUserPosition!.longitude);
          var placemark = placemarks[0];
          ref.read(locationProvider.notifier).getCurrentLocation(placemark);
          ref
                  .read(userAdditionStateProvider.notifier)
                  .listOfUserInfo[MapForUserInfo.userLocation] =
              "${placemark.country},${placemark.locality}";
          log(" Country : ${placemark.country}, Locality :  ${placemark.locality}, Postal Code : ${placemark.postalCode}, Administrative Area : ${placemark.administrativeArea} , Street : ${placemark.street} ,Sub_location ${placemark.subLocality}");
          success = true;
          ref
                  .read(userAdditionStateProvider.notifier)
                  .listOfUserInfo[MapForUserInfo.userLocation] =
              "${placemark.country},${placemark.locality}";
          Navigator.pop(context);
        } catch (e) {
          retryCount++;
          log("Attempt $retryCount failed: $e");
          if (retryCount >= maxRetries) {
            log("Max retries reached. Could not fetch location.");
            Fluttertoast.showToast(
                msg: "Failed in Getting Location",
                textColor: Colors.white,
                backgroundColor: Colors.red);
            Navigator.pop(context);
          }
        }
      }
    }

    return Row(
      children: [
        const Spacer(
          flex: 30,
        ),
        Expanded(
            flex: 40,
            child: MaterialButton(
              onPressed: () async {
                final connectivityResult =
                    await Connectivity().checkConnectivity();
                if (connectivityResult[0] == ConnectivityResult.none) {
                  // No internet connection
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No internet connection'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  coordinatesIntoLocation();
                }
              },
              color: const Color.fromARGB(255, 14, 63, 103),
              child: const Text(
                "Add Location",
                style: TextStyle(color: Colors.white),
              ),
            )),
        const Spacer(
          flex: 30,
        ),
      ],
    );
  }
}

class CurrentLocationText extends ConsumerWidget {
  const CurrentLocationText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentLocation = ref.watch(locationProvider);
    return Row(
      children: [
        const Spacer(
          flex: 30,
        ),
        Expanded(
            flex: 40,
            child: FittedBox(
              child: Text(
                "${currentLocation.country},${currentLocation.locality}",
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
            )),
        const Spacer(
          flex: 30,
        ),
      ],
    );
  }
}
