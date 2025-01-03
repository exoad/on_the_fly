import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/theme.dart';

class ProgressBarPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color trackColor;
  final double radius;

  ProgressBarPainter(
      {required this.progress,
      required this.progressColor,
      required this.trackColor,
      this.radius = kRRArc});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(radius)),
        Paint()
          ..color = trackColor
          ..style = PaintingStyle.fill);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width * progress, size.height),
            Radius.circular(radius)),
        Paint()
          ..color = progressColor
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// similar to [ProgressBarPainter] but the progress paint section uses a [LinearGradient]
class GradientProgressBarPainter extends CustomPainter {
  final double progress;
  final LinearGradient progressGradient;
  final Color trackColor;
  final double radius;

  GradientProgressBarPainter(
      {required this.progress,
      required this.progressGradient,
      required this.trackColor,
      this.radius = kRRArc});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(radius)),
        Paint()
          ..color = trackColor
          ..style = PaintingStyle.fill);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width * progress, size.height),
            Radius.circular(radius)),
        Paint()
          ..shader = progressGradient
              .createShader(Rect.fromLTWH(0, 0, size.width * progress, size.height))
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
