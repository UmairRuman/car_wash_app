import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';

class CurrentLocationNotifier extends Notifier<Placemark> {
  @override
  Placemark build() {
    return const Placemark();
  }

  void getCurrentLocation(Placemark placeMark) {
    state = placeMark;
  }
}

final locationProvider = NotifierProvider<CurrentLocationNotifier, Placemark>(
    CurrentLocationNotifier.new);
