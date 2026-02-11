import 'dart:math';
import 'package:flutter/material.dart';

class WavyProgress extends StatelessWidget {
  final double progress;

  const WavyProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WavePainter(
        progress: progress.clamp(0.0, 1.0),
        color: Theme.of(context).colorScheme.secondary,
      ),
      size: const Size(double.infinity, 26),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress;
  final Color color;

  _WavePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final waveWidth = size.width * progress;

    for (double x = 0; x <= waveWidth; x++) {
      final y = size.height / 2 +
          sin((x / size.width) * pi * 4) * 6;
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
