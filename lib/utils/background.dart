import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  final scaleY;
  CurvePainter({this.scaleY = 0.35});

  final color1 = Colors.teal.withOpacity(0.9);
  final color2 = Colors.teal.withOpacity(0.6);
  final color3 = Colors.teal.withOpacity(0.4);

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();

    final h = size.height * scaleY;

    path.lineTo(0, h * 0.75);
    path.quadraticBezierTo(
        size.width * 0.10, h * 0.70, size.width * 0.17, h * 0.90);
    path.quadraticBezierTo(size.width * 0.20, h, size.width * 0.25, h * 0.90);
    path.quadraticBezierTo(
        size.width * 0.40, h * 0.40, size.width * 0.50, h * 0.70);
    path.quadraticBezierTo(
        size.width * 0.60, h * 0.85, size.width * 0.65, h * 0.65);
    path.quadraticBezierTo(size.width * 0.70, h * 0.90, size.width, 0);
    path.close();

    paint.color = color3;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, h * 0.50);
    path.quadraticBezierTo(
        size.width * 0.10, h * 0.80, size.width * 0.15, h * 0.60);
    path.quadraticBezierTo(
        size.width * 0.20, h * 0.45, size.width * 0.27, h * 0.60);
    path.quadraticBezierTo(size.width * 0.45, h, size.width * 0.50, h * 0.80);
    path.quadraticBezierTo(
        size.width * 0.55, h * 0.45, size.width * 0.75, h * 0.75);
    path.quadraticBezierTo(size.width * 0.85, h * 0.93, size.width, h * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = color2;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, h * 0.75);
    path.quadraticBezierTo(
        size.width * 0.10, h * 0.55, size.width * 0.22, h * 0.70);
    path.quadraticBezierTo(
        size.width * 0.30, h * 0.90, size.width * 0.40, h * 0.75);
    path.quadraticBezierTo(
        size.width * 0.52, h * 0.50, size.width * 0.65, h * 0.70);
    path.quadraticBezierTo(size.width * 0.75, h * 0.85, size.width, h * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = color1;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
