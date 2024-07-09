import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomStateProvider =
    NotifierProvider<BottomBarController, int>(BottomBarController.new);

class BottomBarController extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void currentNavigationState(int index) {
    state = index;
  }
}
