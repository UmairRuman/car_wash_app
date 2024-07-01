import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialMediaIcons extends StatefulWidget {
  const SocialMediaIcons({super.key});

  @override
  State<SocialMediaIcons> createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends State<SocialMediaIcons> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  onTapOnGoogleIcon() {
    signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
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
        Expanded(flex: 20, child: Image.asset(twitterIconPath)),
        const Spacer(
          flex: 25,
        )
      ],
    );
  }
}
