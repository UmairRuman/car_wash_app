import 'package:car_wash_app/Client/pages/chooser_page/controller/phone_authenticatio_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: const Color.fromARGB(255, 16, 118, 202)),
    borderRadius: BorderRadius.circular(10),
  ),
);

class PhoneNoOTP extends ConsumerWidget {
  const PhoneNoOTP({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        animationCurve: Curves.bounceOut,
        showCursor: false,
        length: 6,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        controller: ref.read(phoneNumberStateProvider.notifier).otpTEC,
      ),
    );
  }
}

class BtnAuthenticatePhoneNo extends ConsumerWidget {
  const BtnAuthenticatePhoneNo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(children: [
      const Spacer(flex: 40),
      Expanded(
        flex: 20,
        child: FloatingActionButton(
          onPressed: () async {
            await ref.read(phoneNumberStateProvider.notifier).verifyOtp();
          },
          backgroundColor: Colors.orange,
          child: const FittedBox(child: Text("Authenticate")),
        ),
      ),
      const Spacer(flex: 40),
    ]);
  }
}
