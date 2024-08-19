import 'package:url_launcher/url_launcher.dart';

void openMap(double latitude, double longitude) async {
  final String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

  if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
    await launchUrl(Uri.parse(googleMapsUrl));
  } else {
    throw 'Could not open the map.';
  }
}
