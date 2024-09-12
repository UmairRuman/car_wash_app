import 'dart:developer';

import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/images_path.dart'; // Assuming you have this file for the icon paths.
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialMediaIcons extends StatefulWidget {
  const SocialMediaIcons({super.key});

  @override
  State<SocialMediaIcons> createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends State<SocialMediaIcons> {
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
    String? twitterToken = prefs.getString('twitterAccessToken');
    String? twitterTokenSecret = prefs.getString('twitterAccessTokenSecret');
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

        // Sign in to Firebase with Twitter credentials
        final AuthCredential twitterCredential = TwitterAuthProvider.credential(
          accessToken: res.credentials.token,
          secret: res.credentials.tokenSecret,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(twitterCredential);

        User? user = userCredential.user;
        if (user != null) {
          log('User authenticated successfully with Twitter and Firebase: ${user.displayName}');
          Navigator.pop(context);
        } else {
          log('Failed to authenticate with Firebase.');
          Navigator.pop(context);
        }

        setState(() {});
      } catch (e) {
        log('Failed to obtain access token: $e');
        Navigator.pop(context);
      }
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

      // Check if user is already signed in with Google
      if (await googleSignIn.isSignedIn()) {
        // If user is signed in, get the current Google user
        final GoogleSignInAccount? googleUser = googleSignIn.currentUser;

        if (googleUser != null) {
          // Authenticate with Firebase using the existing Google credentials
          await _authenticateWithFirebase(googleUser);

          // Check if the user's phone number is authenticated
          _checkPhoneNumberVerification();
          return;
        }
      }

      // If the user is not signed in, prompt them to sign in
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        await _authenticateWithFirebase(googleUser);
        _checkPhoneNumberVerification();
      }
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Failed Login",
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
      log("Error in logging in with Google: ${e.toString()}");
    }
  }

  Future<void> _authenticateWithFirebase(GoogleSignInAccount googleUser) async {
    try {
      // Authenticate with Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);

      log('User authenticated successfully with Google: ${googleUser.email}');
      setState(() {});

      Fluttertoast.showToast(
        msg: "Login Successfully",
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Failed Login",
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
      log("Error in authenticating with Firebase: ${e.toString()}");
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
