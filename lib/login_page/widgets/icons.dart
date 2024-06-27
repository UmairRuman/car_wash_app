import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class SocialMediaIcons extends StatefulWidget {
  const SocialMediaIcons({super.key});

  @override
  State<SocialMediaIcons> createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends State<SocialMediaIcons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 25,
        ),
        Expanded(flex: 20, child: Image.asset(googleIconPath)),
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
