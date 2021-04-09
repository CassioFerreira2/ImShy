import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:imshy/constants.dart';

class ImshyBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFFF0000)),
      child: CustomPaint(
        painter: BottomBarShape(),
      ),
    );
  }
}

class BottomBarShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0
      ..isAntiAlias = true
      ..shader = LinearGradient(colors: [
        primaryRed.withOpacity(0.3),
        textAndOtherThings.withOpacity(0.3),
      ]).createShader(Rect.fromCenter(
          center: Offset(140, size.height / 2), width: 140 * 2, height: 50.0));

    // Method to convert degree to radians
    double degToRad(num deg) => deg * (Math.pi / 180.0);

    Path path = Path();
    path.moveTo(0.0, size.height - 50.0);
    path.lineTo(140.0 * 2, size.height - 50.0);
    path.arcToPoint(Offset(140 * 2, size.height + 70),
        radius: Radius.circular(60));
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BottomBarShape oldDelegate) => false;
}
