import 'package:flutter/material.dart';

//This is the Lower container for decoration
class LowerContainerPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final heightIntoTwelve = height / 12;
    final widthIntoTwelve = width / 12;
    Path path = Path();
    path.quadraticBezierTo(
        widthIntoTwelve * 4, heightIntoTwelve * 4, widthIntoTwelve * 4, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
