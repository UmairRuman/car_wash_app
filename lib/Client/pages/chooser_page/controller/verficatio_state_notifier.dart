import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneNumberVerificationStateNotifier extends Notifier<VerficationStates> {
  @override
  VerficationStates build() {
    return VerificationIntialState();
  }

  onVerificationButtonClick() {
    state = VerificationStartState();
  }

  onOtpReceived() {
    state = VerificationInProcessState();
  }

  onConfirmButtonClick() {
    state = VerificationCompletedState();
  }
}

final verificationCurrentStateProvider =
    NotifierProvider<PhoneNumberVerificationStateNotifier, VerficationStates>(
        PhoneNumberVerificationStateNotifier.new);

abstract class VerficationStates {}

class VerificationIntialState extends VerficationStates {}

class VerificationStartState extends VerficationStates {}

class VerificationInProcessState extends VerficationStates {}

class VerificationCompletedState extends VerficationStates {}

class VerificationErrorState extends VerficationStates {}
