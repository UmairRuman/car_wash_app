import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageStateNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  onReciveImagePathFromCloud(String imagePath) {
    state = imagePath;
  }

  void resetStata() {
    state = "";
  }
}

final profilePageImageStateProvider =
    NotifierProvider<ImageStateNotifier, String>(ImageStateNotifier.new);
