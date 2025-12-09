import 'dart:math';
import 'package:flutter/material.dart';

class NagadaPulseVisualizer2 extends StatefulWidget {
  final double size;
  final bool animate;
  final Color color;

  const NagadaPulseVisualizer2({
    super.key,
    this.size = 120,
    this.animate = true,
    this.color = const Color(0xFFEF233C), // heartbeat red
  });

  @override
  State<NagadaPulseVisualizer2> createState() => _NagadaPulseVisualizerState();
}

class _NagadaPulseVisualizerState extends State<NagadaPulseVisualizer2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PulsePainter(
        progress: _controller.value,
        color: widget.color,
      ),
      size: Size(widget.size, widget.size / 2),
    );
  }
}

class _PulsePainter extends CustomPainter {
  final double progress;
  final Color color;

  _PulsePainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.9)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // ECG-like waveform using sine wave and a controlled spike
    final mid = size.height / 2;
    final width = size.width;

    for (double x = 0; x < width; x++) {
      final t = (x / width) * 2 * pi + progress * 2 * pi;

      // smooth heart beat base wave
      double y = sin(t * 3) * 8;

      // add spike at phase location to simulate systole
      if ((t % (2 * pi)) < 0.4) {
        y += pow(sin(t * 10), 20) * 80;
      }

      path.lineTo(x, mid - y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => true;
}
