import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as Math;

import 'package:imshy/constants.dart';

class ImshyTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      ..strokeWidth = 3.5
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = textAndOtherThings;
    final shadowPaint = Paint()
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4)
      ..color = Colors.black.withOpacity(0.9);

    // Method to convert degree to radians
    double degToRad(num deg) => deg * (Math.pi / 180.0);

    Path path = Path();
    path.moveTo(size.width, 48.0);
    path.lineTo(size.width * 0.6, 48.0);
    path.arcToPoint(Offset(size.width * 0.5, 0.0), radius: Radius.circular(50));
    path.lineTo(size.width, 0.0);
    path.close();

    Path shadowPath = Path()
      ..moveTo(size.width, 48.0)
      ..lineTo(size.width * 0.6, 48.0)
      ..arcToPoint(Offset(size.width * 0.5, 0.0), radius: Radius.circular(50))
      ..arcToPoint(Offset(size.width * 0.6, 48.0),
          radius: Radius.circular(50), clockwise: false)
      ..lineTo(size.width, 48.0);

    canvas.drawPath(shadowPath, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BottomBarShape oldDelegate) => false;
}
