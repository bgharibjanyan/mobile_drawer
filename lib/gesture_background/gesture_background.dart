
import 'package:flutter/material.dart';

class DottedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent
      ..strokeWidth = 2;

    // Size of the grid
    var space = 35.0;

    for (double i = 0; i < size.width; i += space) {
      for (double j = 0; j < size.height; j += space) {
        // Draw the dot
        canvas.drawCircle(Offset(i, j), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}