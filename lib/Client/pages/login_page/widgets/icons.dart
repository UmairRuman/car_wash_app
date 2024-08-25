import 'dart:developer';

import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
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
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Failed to authenticate!",
          textColor: Colors.white,
          backgroundColor: Colors.green);
      log('Failed to authenticate: $e');
    }
  }

  void showWebViewDialog(String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
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
        } else {
          log('Failed to authenticate with Firebase.');
        }

        setState(() {});
      } catch (e) {
        log('Failed to obtain access token: $e');
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
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.email',
        ],
      ).signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        log('User authenticated successfully with Google: ${googleUser.email}');
        setState(() {});
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Login Successfully",
            textColor: Colors.white,
            backgroundColor: Colors.green);
      }
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Failed Login",
          textColor: Colors.white,
          backgroundColor: Colors.red);
      log("Error in logging in with Google: ${e.toString()}");
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
