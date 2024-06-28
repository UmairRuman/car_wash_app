import 'package:flutter/material.dart';

class ClipedDecoratedContainer extends CustomClipper<Path> {
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
    path.moveTo(widthIntoTwelve * 1, 0);
    path.lineTo(widthIntoTwelve * 11, 0);
    path.lineTo(widthIntoTwelve * 11, heightIntoTen * 6);
    path.conicTo(
        centerWidth, height, widthIntoTwelve * 1, heightIntoTen * 6, 1);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
