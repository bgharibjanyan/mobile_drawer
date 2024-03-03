import 'package:flutter/material.dart';
class GrowingFigurePainter extends CustomPainter {
  final List<Offset> points;

  GrowingFigurePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {

    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;


    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }


    path.close();


    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
