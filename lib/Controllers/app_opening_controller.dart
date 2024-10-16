import 'package:flutter_riverpod/flutter_riverpod.dart';

final appOpeningStateProvider =
    NotifierProvider<AppOpeningController, String>(AppOpeningController.new);

class AppOpeningController extends Notifier<String> {
  bool isUserLoginFirstTimeAfterReinstalling = false;
  bool isUserLogin = false;
  @override
  String build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
