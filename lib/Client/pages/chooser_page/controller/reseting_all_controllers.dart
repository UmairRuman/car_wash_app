import 'package:car_wash_app/Client/pages/chooser_page/controller/color_controller.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/image_controller.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/location_notifier.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/save_data_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resetingAllControllers =
    NotifierProvider<ResetingAllControllers, bool>(ResetingAllControllers.new);

class ResetingAllControllers extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void resetControllers() {
    ref.read(colorNotifierProvider.notifier).resetColorState();
    ref.read(locationProvider.notifier).resetLocation();
    ref.read(profilePageImageStateProvider.notifier).resetStata();
    ref.read(userSaveStateProvider.notifier).resetSaveBtnState();
  }
}
