import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTextAfterOtpVerfication extends StatelessWidget {
  const AnimatedTextAfterOtpVerfication({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'Otp Verfied Successfully',
            textStyle: const TextStyle(
              fontSize: 22.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
        totalRepeatCount: 1,
      ),
    );
  }
}
