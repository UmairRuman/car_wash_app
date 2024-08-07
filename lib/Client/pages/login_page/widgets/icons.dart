import 'dart:developer';

import 'package:car_wash_app/utils/images_path.dart'; // Assuming you have this file for the icon paths.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
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
  }

  Future<void> authenticate() async {
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
        showWebViewDialog(authUrl!);
      }
    } catch (e) {
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
                      handleCallback(Uri.parse(request.url));
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
              if (isLoading) CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  Future<void> handleCallback(Uri uri) async {
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
        // Store these tokens for future requests
      } catch (e) {
        log('Failed to obtain access token: $e');
      }
    }
  }

  Future<void> signInWithTwitter() async {
    authenticate();
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.email',
        ],
      ).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      var credentials;

      // Create a new credential
      credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      log("Error in loging in with Google ${e.toString()}");
    }

    // Once signed in, return the UserCredential
    return null;
  }

  onTapOnGoogleIcon() {
    signInWithGoogle();
  }

  onTapTwitterIcon() {
    signInWithTwitter();
  }

  @override
  Widget build(BuildContext context) {
    log('Auth URL in build: $authUrl');
    return Row(
      children: [
        const Spacer(
          flex: 25,
        ),
        Expanded(
            flex: 20,
            child: InkWell(
                onTap: onTapOnGoogleIcon, child: Image.asset(googleIconPath))),
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 20,
            child: InkWell(
                onTap: onTapTwitterIcon, child: Image.asset(twitterIconPath))),
        const Spacer(
          flex: 25,
        )
      ],
    );
  }
}
