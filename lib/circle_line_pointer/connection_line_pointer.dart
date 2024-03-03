import 'dart:math';
import 'package:flutter/material.dart';

class ConnectionLinesPainter extends CustomPainter {
  final List<Offset> circlePositions;
  final bool isInError;
  ConnectionLinesPainter(this.circlePositions, this.isInError);

  double calculateDistance(Offset offset1, Offset offset2) {
    double dx = offset1.dx - offset2.dx;
    double dy = offset1.dy - offset2.dy;
    return sqrt(dx * dx + dy * dy);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = this.isInError ? Colors.grey:Colors.black
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < circlePositions.length - 1; i++) {
      Offset startPoint = circlePositions[i];
      Offset endPoint = circlePositions[i + 1];
      canvas.drawLine(startPoint, endPoint, paint);

      double distance = calculateDistance(startPoint, endPoint);
      Offset textPosition = Offset((startPoint.dx + endPoint.dx) / 2, (startPoint.dy + endPoint.dy) / 2);


      double angle = atan2(endPoint.dy - startPoint.dy, endPoint.dx - startPoint.dx);
      if (endPoint.dx < startPoint.dx) {
        angle += pi;
      }
      canvas.save();
      canvas.translate(textPosition.dx, textPosition.dy);
      canvas.rotate(angle);
      TextSpan span = TextSpan(
        text: distance.toStringAsFixed(2),
        style: const TextStyle(fontSize: 14, color: Colors.blueAccent,height: 5),
      );
      TextPainter text = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      text.layout();
      text.paint(canvas, Offset(-text.width / 2, - text.height / 2));
      canvas.restore();
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}