import 'package:flutter/material.dart';

class CirclePointer extends CustomPainter {

  final Offset position;
  final double radius;
  final Color color;

  const CirclePointer(this.position, this.radius,this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Paint borderPaint = Paint()..color = (color==const Color(0xFF0098EE))?const Color(0xFFFDFDFD):const Color(0xFF377BBB);

    canvas.drawCircle(position, 8.5, borderPaint);
    canvas.drawCircle(position, 6.5, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}