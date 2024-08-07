import 'package:flutter_riverpod/flutter_riverpod.dart';

final verficationStateProvider =
    NotifierProvider<VerificationStateNotifier, bool>(
        VerificationStateNotifier.new);

class VerificationStateNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  onVerficationPassed() {
    state = !state;
  }
}
