import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Client/pages/sign_up_page/controller/auth_state_change_notifier.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/Functions/geo_locator.dart';
import 'package:car_wash_app/ModelClasses/admin_info_function.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/navigation/navigation.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await getAdminIdFromFireStore();
        var position = await determinePosition();
        currentUserPostion = position;
        log("Longitude ${currentUserPostion!.longitude}");
        log("Lotitude ${currentUserPostion!.latitude}");
      },
    );
    for (var imagespath in listOfPreviousWorkImages) {
      precacheImage(AssetImage(imagespath), context);
    }
    log("Main App rebuild");
    ref.watch(authStateProvider);
    return MaterialApp(
      initialRoute: FirstPage.pageName,
      onGenerateRoute: onGenerateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthHandler(),
    );
  }
}

class AuthHandler extends ConsumerWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final currentUser = FirebaseAuth.instance.currentUser;
    log("Auth Handeler Rebuild");
    return authState.when(
      data: (user) {
        if (user == null) {
          return const FirstPage();
        } else if (currentUser!.phoneNumber != null &&
            prefs!.getBool(ShraedPreferncesConstants.isServiceProvider) !=
                null &&
            prefs!.getBool(ShraedPreferncesConstants.isServiceProvider)!) {
          return const AdminSideHomePage();
        } else if (currentUser.phoneNumber != null &&
            prefs!.getBool(ShraedPreferncesConstants.isServiceProvider) !=
                null &&
            !prefs!.getBool(ShraedPreferncesConstants.isServiceProvider)!) {
          return const HomePage();
        } else {
          SchedulerBinding.instance.addPostFrameCallback(
            (timeStamp) {
              Navigator.pushNamed(context, ChooserPage.pageName);
            },
          );

          log('User is authenticated: ${user.uid} ${user.email} ${user.displayName} ');
          ref
              .read(userAdditionStateProvider.notifier)
              .listOfUserInfo[MapForUserInfo.userId] = user.uid;
          ref
              .read(userAdditionStateProvider.notifier)
              .listOfUserInfo[MapForUserInfo.email] = user.email;
          return const ChooserPage();
        }
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Something went wrong: $error'),
        ),
      ),
    );
  }
}
