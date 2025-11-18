import 'dart:math';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';

import 'border_types.dart' show BorderType;

abstract class CircularBorderType extends BorderType {
  const CircularBorderType();
}

class DottedCircularBorderByNumber extends CircularBorderType {
  final int numberOfDashes;
  final Color activeColor;
  final int activeCount;
  final Color inactiveColor;
  final double strokeWidth;
  final double dashGap;

  /// Creates a circular border around the child widget by number of dashes
  /// Accepts a required argument [numberOfDashes]
  ///
  /// [activeCount] represents dashes that are to be painted in color [activeColor]
  /// ## Note
  /// [activeCount] cannot exceed [numberOfDashes].
  const DottedCircularBorderByNumber({
    required this.numberOfDashes,
    this.activeCount = 1,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.strokeWidth = 2,
    this.dashGap = 5,
  }) : assert(numberOfDashes > 0, 'numberOfDashes must be greater than 0.'),
       assert(activeCount >= 0, 'activeCount cannot be negative.'),
       assert(
         activeCount <= numberOfDashes,
         'activeCount cannot be greater than numberOfDashes.',
       );

  @override
  void paint(Canvas canvas, Size size, Offset offset) {
    final center = Offset(
      offset.dx + size.width / 2,
      offset.dy + size.height / 2,
    );
    final rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    );

    final radius = rect.width / 2;

    final activePaint =
        Paint()
          ..color = activeColor
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final inactivePaint =
        Paint()
          ..color = inactiveColor
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    // Convert pixel gap into angle gap
    double gapAngle = dashGap / radius;

    // Angle per dash
    double dashAngle = (2 * pi - numberOfDashes * gapAngle) / numberOfDashes;

    double startAngle = 0;

    for (int i = 0; i < numberOfDashes; i++) {
      canvas.drawArc(
        rect,
        startAngle,
        dashAngle,
        false,
        (activeCount >= (i + 1) ? activePaint : inactivePaint),
      );

      startAngle += dashAngle + gapAngle;
    }
  }
}

class DefaultDottedCircularBorder extends CircularBorderType {
  final double strokeWidth;
  final Color color;
  final double dashGap;
  final double dashWidth;

  /// Creates a border around the child widget
  ///
  /// Draws as many dots as required to form a circle
  ///
  /// See [DottedCircularBorderByNumber] to find the differences,
  ///
  const DefaultDottedCircularBorder({
    this.strokeWidth = 2,
    this.color = Colors.black,
    this.dashGap = 5,
    this.dashWidth = 5,
  });

  @override
  void paint(Canvas canvas, Size size, Offset offset) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final center = Offset(
      offset.dx + size.width / 2,
      offset.dy + size.height / 2,
    );
    final radius = min(size.width, size.height) / 2 - strokeWidth / 2;

    final circumference = 2 * pi * radius;
    final dashCount = (circumference / (dashWidth + dashGap)).floor();
    final angleStep = 2 * pi / dashCount;
    final sweepAngle = dashWidth / circumference * 2 * pi;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * angleStep;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }
}
