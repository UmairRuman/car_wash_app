import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

//Variable to get the current user location
Position? currentUserPosition;

Future<Position?> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    _showLocationServicesDialog(
        context); // Function to show a dialog to enable location services.
    return null;
  }

  // Check for location permissions.
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(
          msg: "Kindly turn on the location permission for this app.");
      return null;
    }
  }

  // Handle the case where location permissions are denied forever.
  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(
        msg:
            "Location permissions are permanently denied, we cannot request permissions.");
    return null;
  }

  // If permissions are granted, try to get the current position.
  try {
    Position position = await Geolocator.getCurrentPosition();
    currentUserPosition = position; // Update the current user position.
    return position;
  } catch (e) {
    // Handle the case where getting the position fails.
    Fluttertoast.showToast(
        msg: "Failed to get the current location. Please try again.");
    return null;
  }
}

void _showLocationServicesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text(
            'Location services are disabled. Please enable them in settings.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
