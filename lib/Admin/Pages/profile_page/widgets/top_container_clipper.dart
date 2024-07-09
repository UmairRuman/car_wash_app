import 'package:flutter/material.dart';

class ProfilePageClipedContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    final centerWidth = width / 2;
    final centerHeight = height / 2;
    final widthIntoTwelve = width / 12;
    final heightIntoTen = height / 10;
    //Path for decorated Shape
    Path path = Path();
    path.lineTo(width, 0);
    path.lineTo(width, heightIntoTen * 6);
    path.conicTo(centerWidth, height, 0, heightIntoTen * 6, 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
