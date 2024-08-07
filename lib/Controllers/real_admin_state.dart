import 'package:flutter_riverpod/flutter_riverpod.dart';

final realAdminStateProvider =
    NotifierProvider<RealAdminStateNotifier, bool>(RealAdminStateNotifier.new);

class RealAdminStateNotifier extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  void isRealAdmin() {
    state = false;
  }
}
