import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final bool isActive;
  final int seed;
  WavePainter({required this.isActive, required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFF3B30)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    // Simple wavy path for demonstration, randomized slightly by seed
    double x = 0;
    while (x < size.width) {
      double fluctuation = isActive ? (sin(seed + x) * 10) : 0;
      path.lineTo(
        x + 20,
        size.height *
            (0.6 +
                (isActive ? 0.2 : 0.1) * (x % 60 == 0 ? 1 : -1) +
                (fluctuation / 100)),
      );
      path.lineTo(
        x + 40,
        size.height *
            (0.5 +
                (isActive ? 0.3 : 0.15) * (x % 80 == 0 ? -1 : 1) -
                (fluctuation / 100)),
      );
      x += 40;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
