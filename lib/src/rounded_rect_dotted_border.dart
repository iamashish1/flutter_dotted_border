import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart';

class RoundedRectDottedBorder extends BorderType {
  final double strokeWidth;
  final Color color;
  final double dashGap;
  final double dashWidth;
  final Radius radius;

  /// Creates a rounded rectangle dotted border
  ///
  /// Customize [radius] for desired corner radius. Also see [Radius] for more info.
  const RoundedRectDottedBorder(
      {this.color = Colors.black,
      this.dashGap = 2.0,
      this.dashWidth = 4.0,
      this.strokeWidth = 2.0,
      this.radius = const Radius.circular(10)});
  @override
  void paint(Canvas canvas, Size size, Offset offset) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final left = offset.dx;
    final top = offset.dy;
    final right = offset.dx + size.width;
    final bottom = offset.dy + size.height;

    final rrect = RRect.fromRectAndRadius(
        Rect.fromLTRB(left, top, right, bottom), radius);

    final path = Path()..addRRect(rrect);

    final metrics = path.computeMetrics();

    for (PathMetric metric in metrics) {
      double distance = 0.0;

      while (distance < metric.length) {
        double clamppedEnd = (distance + dashWidth).clamp(0, metric.length);
        final drawablePath = metric.extractPath(distance, clamppedEnd);
        canvas.drawPath(drawablePath, paint);
        distance += dashGap + dashWidth;
      }
    }
  }
}
