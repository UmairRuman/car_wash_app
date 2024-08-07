import 'package:flutter_riverpod/flutter_riverpod.dart';

final userSaveStateProvider =
    NotifierProvider<SaveDataNotifier, bool>(SaveDataNotifier.new);

class SaveDataNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void onSavedUserState() {
    state = true;
  }
}
