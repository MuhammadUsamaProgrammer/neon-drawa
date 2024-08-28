import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neonTrail/app/screens/model/neon_line_model.dart';
import 'package:neonTrail/app/screens/viewModel/neon_draw_viewModel.dart';

class NeonTrailPainter extends CustomPainter {
  final List<NeonModel> lines;
  final NeonModel currentLine;

  final neonVM = Get.find<NeonVM>();

  NeonTrailPainter(this.lines, this.currentLine);

  @override
  void paint(Canvas canvas, Size size) {
    for (NeonModel line in lines) {
      if (line.offset.isNotEmpty) {
        _drawNeonLine(
          canvas,
          line.offset,
          size,
          line.clr,
          line.width,
          line.rainbow,
          line.neonEffect,
        );
      }
    }

    if (currentLine.offset.isNotEmpty) {
      _drawNeonLine(
        canvas,
        currentLine.offset,
        size,
        currentLine.clr,
        currentLine.width,
        currentLine.rainbow,
        currentLine.neonEffect,
      );
    }
  }

  void _drawNeonLine(Canvas canvas, List<Offset> points, Size size, Color clr,
      double width, bool isRainbow, bool neonEffect) {
    if (points.isEmpty) return;

    final Path path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    if (neonEffect) {
      // Draw the outer glow
      Paint outerGlowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            clr.withOpacity(0.7),
            Colors.transparent,
          ],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: points.last, radius: 100))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, width * 2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = width * 2;
      canvas.drawPath(path, outerGlowPaint);

      // Draw the main glow
      Paint mainGlowPaint = Paint()
        ..shader = LinearGradient(
          colors: isRainbow
              ? [
                  Colors.redAccent,
                  Colors.orangeAccent,
                  Colors.yellowAccent,
                  Colors.greenAccent,
                  Colors.blueAccent,
                  Colors.indigoAccent,
                  Colors.purpleAccent
                ]
              : [
                  clr.withOpacity(0.7),
                  clr.withOpacity(0.7),
                ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, width * 2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = width * 2;
      canvas.drawPath(path, mainGlowPaint);
    }
    // Draw the core line
    Paint corePaint = Paint()
      ..shader = LinearGradient(
        colors: isRainbow
            ? [
                Colors.redAccent,
                Colors.orangeAccent,
                Colors.yellowAccent,
                Colors.greenAccent,
                Colors.blueAccent,
                Colors.indigoAccent,
                Colors.purpleAccent
              ]
            : [
                clr.withOpacity(0.7),
                clr.withOpacity(0.7),
              ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..color = clr
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    canvas.drawPath(path, corePaint);

    // // Define the rainbow colors
    // List<Color> rainbowColors = [
    //   Colors.redAccent,
    //   Colors.orangeAccent,
    //   Colors.yellowAccent,
    //   Colors.greenAccent,
    //   Colors.blueAccent,
    //   Colors.indigoAccent,
    //   Colors.purpleAccent,
    // ];

    // for (int i = 0; i < points.length - 1; i++) {
    //   // Calculate the current color based on the index
    //   Color color = rainbowColors[i % rainbowColors.length];

    //   // Draw the segment of the line with the current color
    //   Paint corePaint = Paint()
    //     ..color = color

    //     ..style = PaintingStyle.stroke
    //     ..strokeWidth = width;

    //   canvas.drawLine(points[i], points[i + 1], corePaint);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
