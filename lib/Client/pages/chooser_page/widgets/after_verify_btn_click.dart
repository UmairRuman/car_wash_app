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
    border: Border.all(color: Colors.blue),
    borderRadius: BorderRadius.circular(10),
  ),
);

class VerficationSection extends StatelessWidget {
  const VerficationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(flex: 50, child: OTPVerification()),
        Expanded(flex: 30, child: BtnConfirmSmsCode()),
        Expanded(flex: 20, child: ResendCodeText())
      ],
    );
  }
}

class OTPVerification extends ConsumerWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = ref.read(phoneNumberStateProvider.notifier).otpTEC;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        showCursor: false,
        length: 6,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        controller: otpController,
        onChanged: (value) {},
        onCompleted: (value) async {},
      ),
    );
  }
}

class BtnConfirmSmsCode extends StatelessWidget {
  const BtnConfirmSmsCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color.fromARGB(255, 14, 63, 103),
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            )),
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}

class ResendCodeText extends StatelessWidget {
  const ResendCodeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 30,
        ),
        Expanded(
            flex: 40,
            child: FittedBox(
                child: Text(
              "Resend Code!",
              style: TextStyle(color: Colors.blue),
            ))),
        Spacer(
          flex: 30,
        )
      ],
    );
  }
}
