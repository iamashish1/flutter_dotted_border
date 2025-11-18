import 'dart:math' show min, sqrt;
import 'dart:ui';

import 'package:flutter/material.dart' show Colors;

import 'border_types.dart';

enum BorderSideToExclude { left, right, top, bottom }

class RectDottedBorder extends BorderType {
  final double strokeWidth;
  final Color color;
  final double dashGap;
  final double dashWidth;

  final Set<BorderSideToExclude> exclude;

  /// Draws a rectangular border
  ///
  /// Use [exclude] set to specify which sides you want to exclude from the border

  const RectDottedBorder({
    this.strokeWidth = 2,
    this.color = Colors.black,
    this.dashGap = 2,
    this.dashWidth = 2,
    this.exclude = const {},
  });

  @override
  void paint(Canvas canvas, Size size, Offset offset) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final left = offset.dx;
    final top = offset.dy;
    final right = left + size.width;
    final bottom = top + size.height;

    void drawDashedLine(Offset start, Offset end) {
      final dx = end.dx - start.dx;
      final dy = end.dy - start.dy;
      final distance = sqrt(dx * dx + dy * dy);
      double drawn = 0;
      while (drawn < distance) {
        final dashLength = min(dashWidth, distance - drawn);
        final tStart = drawn / distance;
        final tEnd = (drawn + dashLength) / distance;
        final segmentStart = Offset(
          start.dx + dx * tStart,
          start.dy + dy * tStart,
        );
        final segmentEnd = Offset(start.dx + dx * tEnd, start.dy + dy * tEnd);
        canvas.drawLine(segmentStart, segmentEnd, paint);
        drawn += dashWidth + dashGap;
      }
    }

    final halfStroke = strokeWidth / 2;
    if (!exclude.contains(BorderSideToExclude.top)) {
      drawDashedLine(
        Offset(left - halfStroke, top),
        Offset(right + halfStroke, top),
      );
    } // Top
    if (!exclude.contains(BorderSideToExclude.left)) {
      drawDashedLine(
        Offset(left, top - halfStroke),
        Offset(left, bottom + halfStroke),
      );
    } // Left

    if (!exclude.contains(BorderSideToExclude.bottom)) {
      drawDashedLine(
        Offset(left - halfStroke, bottom),
        Offset(right + halfStroke, bottom),
      );
    } // Bottom
    if (!exclude.contains(BorderSideToExclude.right)) {
      drawDashedLine(
        Offset(right, top - halfStroke),
        Offset(right, bottom + halfStroke),
      );
    } // Right
  }
}
