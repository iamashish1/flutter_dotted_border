import 'package:flutter/material.dart';

/// Base Class for all border types to be used in [DottedBorder] [borderType]
abstract class BorderType {
  const BorderType();

  ///Abstract method to be overridden by all the classes inheriting it
  void paint(Canvas canvas, Size size, Offset offset);
}
