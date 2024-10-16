import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Controllers/app_opening_controller.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/Functions/admin_info_function.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication {
  static UserCollection userCollection = UserCollection();
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.email',
    ],
  );

  //We will use this method when we have to authenticate user first time when installing the app
  static void authenticateFirstTimeWhenInstallingApp() {}
//We will use this method when the user is already sign in with google but he reinstalls the app or clear data of his app
  static Future<void> signingUserWhenReinstallingAppOrInstallingForTheFirstTime(
      WidgetRef ref, BuildContext context) async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      log("Google user id ${googleUser.id}");
      UserCredential userCredential =
          await userCredentialsAfterSignIn(googleUser);
      if (userCredential.user != null) {
        final userSnapshot = await UserCollection.userCollection
            .doc(userCredential.user!.uid)
            .get();
        if (userSnapshot.exists) {
          await prefs?.setBool(
              SharedPreferncesConstants.isUserInfoProvided, true);
          bool isServiceProvider =
              await userCollection.getUserInfo(userCredential.user!.uid);
          await prefs?.setBool(
              SharedPreferncesConstants.isServiceProvider, isServiceProvider);
          await getAdminIdFromFireStore(ref);
          ref.read(appOpeningStateProvider.notifier).isUserLogin = true;
          ref
              .read(appOpeningStateProvider.notifier)
              .isUserLoginFirstTimeAfterReinstalling = true;

          Navigator.pop(context);
          if (isServiceProvider) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AdminSideHomePage.pageName,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.pageName,
              (route) => false,
            );
          }
        } else {
          final String userName = userCredential.user!.displayName!;
          final String email = userCredential.user!.email!;
          User? user = userCredential.user;
          user!.uid;
          await ref
              .read(userAdditionStateProvider.notifier)
              .addUser(userName, email, "");
          prefs!.setBool(SharedPreferncesConstants.isUserInfoProvided, false);
          Navigator.pop(context);
          Navigator.pushNamed(context, ChooserPage.pageName);
        }
      } else {
        Fluttertoast.showToast(
          msg: "User not found",
          textColor: Colors.white,
          backgroundColor: Colors.green,
        );
      }
    }
  }

  //We will authenticate user when he signs out and want to sign in again with google
  static Future<bool?> signingInUser(WidgetRef ref) async {
    bool? isServiceProvider;
    final GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();

    if (googleUser != null) {
      ref.read(appOpeningStateProvider.notifier).isUserLogin = true;
      UserCredential userCredential =
          await userCredentialsAfterSignIn(googleUser);
      await prefs?.setBool(SharedPreferncesConstants.isUserInfoProvided, true);
      isServiceProvider =
          await userCollection.getUserInfo(userCredential.user!.uid);
      await prefs?.setBool(
          SharedPreferncesConstants.isServiceProvider, isServiceProvider);
    }
    return isServiceProvider;
  }

  static Future<UserCredential> userCredentialsAfterSignIn(
      GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create credential for Firebase
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with Firebase
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  }
}
