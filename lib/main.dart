import 'dart:developer';

import 'package:car_wash_app/navigation/navigation.dart';
import 'package:car_wash_app/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/pages/sign_up_page/controller/auth_state_change_notifier.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    log("Auth Handeler Rebuild");
    return authState.when(
      data: (user) {
        if (user == null) {
          return const FirstPage();
        } else {
          SchedulerBinding.instance.addPostFrameCallback(
            (timeStamp) {
              Navigator.pushNamed(context, HomePage.pageName);
            },
          );
          log('User is authenticated: ${user.uid} ${user.email}');
          return const HomePage();
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
