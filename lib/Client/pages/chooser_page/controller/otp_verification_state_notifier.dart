import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpVerficationProvider =
    NotifierProvider<OtpVerificationStateNotifier, bool>(
        OtpVerificationStateNotifier.new);

class OtpVerificationStateNotifier extends Notifier<bool> {
  bool isOtpVerified = false;
  @override
  bool build() {
    return false;
  }

  onVerifiedOtp() {
    state = !state;
    isOtpVerified = true;
  }
}
