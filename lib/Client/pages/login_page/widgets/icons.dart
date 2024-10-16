import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/Functions/admin_info_function.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/top_level_classes/google_authentication.dart';
import 'package:car_wash_app/utils/images_path.dart'; // Assuming you have this file for the icon paths.
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialMediaIcons extends ConsumerStatefulWidget {
  const SocialMediaIcons({super.key});

  @override
  ConsumerState<SocialMediaIcons> createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends ConsumerState<SocialMediaIcons> {
  UserCollection userCollection = UserCollection();
  final String consumerKey = 'UqrRottm7foCZtUQN1pXeLXog';
  final String consumerSecret =
      'KPjQqryETBVlGMjUz3Kc6M8s6y0Nyu427DBSHWa9dPM5ZU9C39';
  final String callbackUrl =
      'https://car-wash-app-86a16.firebaseapp.com/__/auth/handler';
  String? authUrl;
  late oauth1.ClientCredentials clientCredentials;
  late oauth1.Authorization auth;
  oauth1.Credentials? tempCredentials;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    clientCredentials = oauth1.ClientCredentials(consumerKey, consumerSecret);
    final platform = oauth1.Platform(
      'https://api.twitter.com/oauth/request_token',
      'https://api.twitter.com/oauth/authorize',
      'https://api.twitter.com/oauth/access_token',
      oauth1.SignatureMethods.hmacSha1,
    );
    auth = oauth1.Authorization(clientCredentials, platform);
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? twitterToken =
        prefs.getString(SharedPreferncesConstants.twitterAccessToken);
    String? twitterTokenSecret =
        prefs.getString(SharedPreferncesConstants.twitterAccessTokenSecret);
    User? googleUser = FirebaseAuth.instance.currentUser;

    if (twitterToken != null && twitterTokenSecret != null) {
      // User is logged in via Twitter
      log('User already authenticated with Twitter.');
    } else if (googleUser != null) {
      // User is logged in via Google
      log('User already authenticated with Google: ${googleUser.email}');
    } else {
      log('No user is authenticated.');
    }
  }

  Future<void> authenticateTwitter() async {
    try {
      log('Requesting temporary credentials...');
      final res = await auth.requestTemporaryCredentials(callbackUrl);
      log('Temporary credentials obtained.');
      setState(() {
        tempCredentials = res.credentials;
        authUrl = auth.getResourceOwnerAuthorizationURI(res.credentials.token);
        isLoading = true;
      });
      log('Auth URL: $authUrl');
      if (authUrl != null) {
        Navigator.of(context).pop();
        showWebViewDialog(authUrl!);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Failed to authenticate!",
            textColor: Colors.white,
            backgroundColor: Colors.green);
        log('Failed to authenticate: $e');
      }
    }
  }

  void showWebViewDialog(String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  navigationDelegate: (NavigationRequest request) {
                    log('Navigating to: ${request.url}');
                    if (request.url.startsWith(callbackUrl)) {
                      handleTwitterCallback(Uri.parse(request.url));
                      Navigator.of(context).pop();
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    log('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    log('Page finished loading: $url');
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onWebResourceError: (error) {
                    log('Web resource error: $error');
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ),
              if (isLoading) const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  Future<void> handleTwitterCallback(Uri uri) async {
    final queryParams = uri.queryParameters;
    final oauthToken = queryParams['oauth_token'];
    final oauthVerifier = queryParams['oauth_verifier'];
    largeTextInformerDialog(context, "Signing you In");

    if (oauthToken != null && oauthVerifier != null) {
      try {
        log('Requesting token credentials...');
        final res = await auth.requestTokenCredentials(
          tempCredentials!,
          oauthVerifier,
        );
        log('Access Token: ${res.credentials.token}');
        log('Access Token Secret: ${res.credentials.tokenSecret}');

        // Store these tokens securely using SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(SharedPreferncesConstants.twitterAccessToken,
            res.credentials.token);
        await prefs.setString(
            SharedPreferncesConstants.twitterAccessTokenSecret,
            res.credentials.tokenSecret);

        // Call the _authenticateWithTwitter method here
        await _authenticateWithTwitter(
            res.credentials.token, res.credentials.tokenSecret);
      } catch (e) {
        log('Failed to obtain access token: $e');
        Navigator.pop(context);
      }
    }
  }

  Future<void> _authenticateWithTwitter(
      String accessToken, String secret) async {
    try {
      // Sign in with Firebase using Twitter credentials
      final AuthCredential twitterCredential = TwitterAuthProvider.credential(
        accessToken: accessToken,
        secret: secret,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(twitterCredential);

      User? user = userCredential.user;
      if (user != null) {
        // Check if user already exists in Firestore
        final userSnapshot =
            await UserCollection.userCollection.doc(user.uid).get();

        if (!userSnapshot.exists) {
          // This is the first time the user is logging in, so add their details
          await ref.read(userAdditionStateProvider.notifier).addUser(
                user.displayName!,
                user.email ?? "No email provided",
                user.phoneNumber ?? "",
              );
          // Set a flag in SharedPreferences to know that user is logged in
          prefs!.setBool(SharedPreferncesConstants.isUserInfoProvided, false);
          Navigator.pop(context);
          // Navigate to the Chooser page for first-time login
          Navigator.pushNamedAndRemoveUntil(
            context,
            ChooserPage.pageName,
            (route) => false,
          );
        } else {
          // User is already logged in, so update preferences and navigate to their respective page
          bool isUserInfoProvided =
              await userCollection.getServiceProviderInfo(user.uid);
          bool isServiceProvider = await userCollection.getUserInfo(user.uid);
          prefs!.setBool(
              SharedPreferncesConstants.isServiceProvider, isServiceProvider);
          prefs!.setBool(
              SharedPreferncesConstants.isUserInfoProvided, isUserInfoProvided);
          await getAdminIdFromFireStore(ref);
          Navigator.pop(context);
          if (!isUserInfoProvided) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ChooserPage.pageName,
              (route) => false,
            );
          } else if (isServiceProvider) {
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
        }
      }
    } catch (e) {
      log('Error authenticating with Firebase: $e');
    }
  }

  Future<void> signInWithTwitter() async {
    informerDialog(context, "Singing in");
    await authenticateTwitter();
  }

  Future<void> signInWithGoogle() async {
    try {
      informerDialog(context, "Signing In");

      // Create a GoogleSignIn instance
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.email',
        ],
      );

      // Check if the user is already signed in
      if (await googleSignIn.isSignedIn()) {
        log('User is already signed in with Google.');
        // User is already signed in, authenticate with Firebase

        bool? isServiceProvider = await GoogleAuthentication.signingInUser(ref);
        if (isServiceProvider != null) {
          if (!mounted) return;
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
        }
      } else {
        log("User is not signed in with Google.");
        await GoogleAuthentication
            .signingUserWhenReinstallingAppOrInstallingForTheFirstTime(
                ref, context);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
      }
      Fluttertoast.showToast(
        msg: "Failed Login ${e.toString()}",
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
      log("Error in logging in with Google: ${e.toString()}");
    }
  }

  void _checkPhoneNumberVerification() {
    // Get the current Firebase user
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Navigator.pushNamed(
        context,
        AuthHandler.pageName,
      );
    }
  }

  void onTapGoogleIcon() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult[0] == ConnectivityResult.none) {
      // No internet connection
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      signInWithGoogle();
    }
  }

  void onTapTwitterIcon() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult[0] == ConnectivityResult.none) {
      // No internet connection
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      signInWithTwitter();
    }
  }

  @override
  Widget build(BuildContext context) {
    log('Auth URL in build: $authUrl');
    return Row(
      children: [
        const Spacer(flex: 25),
        Expanded(
          flex: 20,
          child: Center(
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(150),
              rippleColor: Colors.red,
              onTap: onTapGoogleIcon,
              child: Image.asset(googleIconPath),
            ),
          ),
        ),
        const Spacer(flex: 10),
        Expanded(
          flex: 20,
          child: Center(
            child: TouchRippleEffect(
              borderRadius: BorderRadius.circular(150),
              rippleColor: Colors.red,
              onTap: onTapTwitterIcon,
              child: Image.asset(twitterIconPath),
            ),
          ),
        ),
        const Spacer(flex: 25),
      ],
    );
  }
}
