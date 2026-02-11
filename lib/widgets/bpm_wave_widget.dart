import 'package:flutter/material.dart';
import 'package:spotify_redesign/widgets/bpm_wave_painter.dart';

class BPMWaveWidget extends StatefulWidget {
  final int bpm;
  final Color color1;
  final Color color2;
  final bool isPlaying;

  const BPMWaveWidget({
    super.key,
    required this.bpm,
    required this.color1,
    required this.color2,
    required this.isPlaying,
  });

  @override
  State<BPMWaveWidget> createState() => _BPMWaveWidgetState();
}

class _BPMWaveWidgetState extends State<BPMWaveWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    // Calculate animation duration based on BPM
    // One full cycle per beat
    final millisecondsPerBeat = (60000 / widget.bpm).round();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: millisecondsPerBeat),
    );

    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(BPMWaveWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle play/pause state changes
    if (oldWidget.isPlaying != widget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }

    // Only restart animation if BPM changes significantly
    if ((oldWidget.bpm - widget.bpm).abs() > 5) {
      final millisecondsPerBeat = (60000 / widget.bpm).round();
      _controller.duration = Duration(milliseconds: millisecondsPerBeat);
      // Reset and restart the animation if playing
      if (widget.isPlaying) {
        _controller.reset();
        _controller.repeat();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BPMWavePainter(
            animationValue: _controller.value,
            bpm: widget.bpm,
            color1: widget.color1,
            color2: widget.color2,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}
