import 'dart:math';
import 'package:flutter/material.dart';

class BlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = min(size.width, size.height) / 2;

    // Create a cloud/flower shape with 8 lobes
    final lobes = 8;
    final angleStep = (2 * pi) / lobes;
    final outerRadius = radius;
    final innerRadius = radius * 0.75;

    for (int i = 0; i <= lobes; i++) {
      final angle = i * angleStep;
      final x = centerX + cos(angle) * outerRadius;
      final y = centerY + sin(angle) * outerRadius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Control point for the curve
        final prevAngle = (i - 1) * angleStep;
        final midAngle = (prevAngle + angle) / 2;

        // Push the control point inward to create lobes
        final cpX = centerX + cos(midAngle) * innerRadius;
        final cpY = centerY + sin(midAngle) * innerRadius;

        path.quadraticBezierTo(cpX, cpY, x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
