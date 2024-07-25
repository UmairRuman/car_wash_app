import 'package:car_wash_app/Client/pages/profile_page/widgets/top_container_clipper.dart';
import 'package:flutter/material.dart';

class TopContainerDecorationProfilePage extends StatelessWidget {
  final String userImagePath;

  const TopContainerDecorationProfilePage(
      {super.key, required this.userImagePath});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: ProfilePageClipedContainer(),
        child: Container(
          color: Colors.blue,
        ));
  }
}
