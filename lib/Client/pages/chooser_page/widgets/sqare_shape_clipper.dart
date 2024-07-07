import 'package:flutter/material.dart';

class SquareShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    final centerWidth = width / 2;
    final centerHeight = height / 2;
    final heightIntoTwelve = height / 12;
    final widthIntoTwelve = width / 12;
    Path path = Path();
    path.moveTo(centerWidth, 0);
    path.lineTo(0, centerHeight);
    path.lineTo(centerWidth, height);
    path.lineTo(width, centerHeight);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
