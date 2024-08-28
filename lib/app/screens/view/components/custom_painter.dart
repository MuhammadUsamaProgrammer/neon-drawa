import 'package:flutter/material.dart';

class NeonTrailPainter extends CustomPainter {
  final List<List<Offset>> lines;
  final List<Offset> currentLine;

  NeonTrailPainter(this.lines, this.currentLine);

  @override
  void paint(Canvas canvas, Size size) {
    for (List<Offset> line in lines) {
      if (line.isNotEmpty) {
        _drawNeonLine(canvas, line, size);
      }
    }

    if (currentLine.isNotEmpty) {
      _drawNeonLine(canvas, currentLine, size);
    }
  }

  void _drawNeonLine(Canvas canvas, List<Offset> points, Size size) {
    if (points.isEmpty) return;

    final Path path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    // Draw the outer glow
    Paint outerGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.purpleAccent.withOpacity(0.2),
          Colors.transparent,
        ],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: points.last, radius: 30))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;
    canvas.drawPath(path, outerGlowPaint);

    // Draw the main glow
    Paint mainGlowPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          // Colors.purpleAccent.withOpacity(0.8),
          // Colors.pinkAccent.withOpacity(0.5),

          Colors.purpleAccent.withOpacity(0.7),
          Colors.purpleAccent.withOpacity(0.7),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
    canvas.drawPath(path, mainGlowPaint);

    // Draw the core line
    Paint corePaint = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawPath(path, corePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
