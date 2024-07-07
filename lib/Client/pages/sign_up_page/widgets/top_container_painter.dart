import 'package:flutter/material.dart';

//This top container painter is used for upper curved decoration
class TopContainerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final heightIntoTwelve = height / 12;
    final widthIntoTwelve = width / 12;
    Path path = Path();
    path.moveTo(widthIntoTwelve * 3, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.cubicTo(
        widthIntoTwelve * 8,
        heightIntoTwelve * 10,
        widthIntoTwelve * 11,
        heightIntoTwelve * 4,
        widthIntoTwelve * 6,
        heightIntoTwelve * 3);
    path.quadraticBezierTo(
        widthIntoTwelve * 3, heightIntoTwelve * 3, widthIntoTwelve * 3, 0);
    path.close();
    final paint = Paint()..color = Colors.blue;
    canvas.drawPath(path, paint);
    ;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
