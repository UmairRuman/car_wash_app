// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
//   return Connectivity().onConnectivityChanged;
// });

// class ConnectivityStatusNotifier extends Notifier<bool> {
//   @override
//   bool build() {
//     return true;
//   }

//   void updateConnectivityStatus(bool isConnected, BuildContext context) {
//     state = isConnected;
//     if (state == false) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("No internet connection")));
//     }
//   }
// }

// final connectivityStatusProvider =
//     NotifierProvider<ConnectivityStatusNotifier, bool>(
//         ConnectivityStatusNotifier.new);
