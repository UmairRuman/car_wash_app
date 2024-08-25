import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';
import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/email_verification_page/view/verification_page.dart';
import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Client/pages/sign_up_page/controller/auth_state_change_notifier.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/Functions/admin_info_function.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/firebase_notifications/notification_service.dart';
import 'package:car_wash_app/navigation/navigation.dart';
import 'package:car_wash_app/payment_methods/Stripe/constants.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MessageDatabase.initializeHiveDatabase();
  Stripe.publishableKey = stripePublishablekey;
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var imagespath in listOfPreviousWorkImages) {
      precacheImage(AssetImage(imagespath), context);
    }

    ref.watch(authStateProvider);
    return MaterialApp(
      initialRoute: FirstPage.pageName,
      onGenerateRoute: onGenerateRoute,
      title: 'Car Wash App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthHandler(),
    );
  }
}

class AuthHandler extends ConsumerStatefulWidget {
  static const pageName = '/authHandler';
  const AuthHandler({super.key});

  @override
  AuthHandlerState createState() => AuthHandlerState();
}

class AuthHandlerState extends ConsumerState<AuthHandler> {
  NotificationServices notificationServices = NotificationServices();
  UserCollection userCollection = UserCollection();

  @override
  void initState() {
    super.initState();
    // log("Current User id ${FirebaseAuth.instance.currentUser!.uid}");
    notificationServices.requestPermission();
    notificationServices.getMessageOnAppOnOpen(context, ref);
    notificationServices.redirectWhenAppInBgOrTermianted(context, ref);
    checkAdminDataInSharedPrefrences();
    log("Is service Provider in condtion ${prefs!.getBool(SharedPreferncesConstants.isServiceProvider)}");

    // if (FirebaseAuth.instance.currentUser != null) {
    //   startBackgroundCleanup(FirebaseAuth.instance.currentUser!.uid);
    // }

    notificationServices.messaging.onTokenRefresh.listen(
      (token) async {
        log("On Device Token refresh: $token ");
        if (FirebaseAuth.instance.currentUser != null) {
          ref.read(userAdditionStateProvider.notifier).updateAdminToken(token);
          ref
              .read(userAdditionStateProvider.notifier)
              .updateUserToken(FirebaseAuth.instance.currentUser!.uid, token);
        }
      },
    );
  }

  void checkAdminDataInSharedPrefrences() async {
    log(" ${await notificationServices.getTokken()} ");
    await getAdminIdFromFireStore(ref);
  }

  @override
  Widget build(BuildContext context) {
    log("Auth handler page rebuild");

    final authState = ref.watch(authStateProvider);
    final currentUser = FirebaseAuth.instance.currentUser;

    return authState.when(
      data: (user) {
        if (user == null) {
          return const FirstPage();
        } else if ((user.phoneNumber != null && user.phoneNumber != "") &&
            prefs!.getBool(SharedPreferncesConstants.isServiceProvider) !=
                null &&
            prefs!.getBool(SharedPreferncesConstants.isServiceProvider)!) {
          //If the service provider is true then we will show him Admin Home Page
          return const AdminSideHomePage();
        } else if ((user.phoneNumber != null && user.phoneNumber != "") &&
            prefs!.getBool(SharedPreferncesConstants.isServiceProvider) !=
                null &&
            !prefs!.getBool(SharedPreferncesConstants.isServiceProvider)!) {
          //If the
          return const HomePage();
        } else if (prefs!
                    .getString(SharedPreferncesConstants.twitterAccessToken) !=
                null &&
            (user.phoneNumber == "" || user.phoneNumber == null)) {
          // If the user is logged in through Twitter and phone number is null
          SchedulerBinding.instance.addPostFrameCallback(
            (timeStamp) {
              Navigator.pushReplacementNamed(context, ChooserPage.pageName);
            },
          );
          log('User logged in via Twitter but phone number is null.');
          return const SizedBox.shrink(); // Temporary widget until redirection
        } else if (user.emailVerified) {
          SchedulerBinding.instance.addPostFrameCallback(
            (timeStamp) {
              Navigator.pushNamed(context, ChooserPage.pageName);
            },
          );

          log('User is authenticated: ${user.uid} ${user.email} ${user.displayName}');
          ref
              .read(userAdditionStateProvider.notifier)
              .listOfUserInfo[MapForUserInfo.userId] = user.uid;
          ref
              .read(userAdditionStateProvider.notifier)
              .listOfUserInfo[MapForUserInfo.email] = user.email;

          return const ChooserPage();
        } else if (!user.emailVerified) {
          return const EmailVerificationPage();
        } else {
          return Container(
            color: Colors.green,
          );
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
