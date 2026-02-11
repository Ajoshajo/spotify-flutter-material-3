import 'dart:math';
import 'package:flutter/material.dart';

class BPMWavePainter extends CustomPainter {
  final double animationValue;
  final int bpm;
  final Color color1;
  final Color color2;

  BPMWavePainter({
    required this.animationValue,
    required this.bpm,
    required this.color1,
    required this.color2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    // Calculate wave parameters based on BPM
    final beatsPerSecond = bpm / 60.0;
    final waveFrequency = beatsPerSecond * 2 * pi;

    // Draw multiple wave layers for depth
    _drawWaveLayer(
      canvas,
      size,
      paint,
      color1.withValues(alpha: 0.15),
      waveFrequency,
      animationValue,
      amplitude: 30,
      yOffset: size.height * 0.3,
    );

    _drawWaveLayer(
      canvas,
      size,
      paint,
      color2.withValues(alpha: 0.1),
      waveFrequency * 1.5,
      animationValue + 0.3,
      amplitude: 40,
      yOffset: size.height * 0.5,
    );

    _drawWaveLayer(
      canvas,
      size,
      paint,
      color1.withValues(alpha: 0.08),
      waveFrequency * 0.8,
      animationValue + 0.6,
      amplitude: 50,
      yOffset: size.height * 0.7,
    );
  }

  void _drawWaveLayer(
    Canvas canvas,
    Size size,
    Paint paint,
    Color color,
    double frequency,
    double phase, {
    required double amplitude,
    required double yOffset,
  }) {
    paint.color = color;

    final path = Path();
    path.moveTo(0, yOffset);

    // Draw smooth sine wave
    for (double x = 0; x <= size.width; x += 2) {
      final normalizedX = x / size.width;
      final y =
          yOffset + amplitude * sin(frequency * normalizedX + phase * 2 * pi);
      path.lineTo(x, y);
    }

    // Close path to fill
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BPMWavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.bpm != bpm ||
        oldDelegate.color1 != color1 ||
        oldDelegate.color2 != color2;
  }
}
