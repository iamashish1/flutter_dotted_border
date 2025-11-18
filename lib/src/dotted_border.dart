import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart';

class DottedBorder extends SingleChildRenderObjectWidget {
  final BorderType borderType;

  /// Creates a dotted border around its [child] using the provided
  /// [borderType].
  ///
  /// The border shape and drawing algorithm are delegated to the [BorderType]
  /// implementation. If no custom type is provided, a rectangular dotted border
  /// is drawn.
  const DottedBorder({
    super.key,
    super.child,
    this.borderType = const RectDottedBorder(),
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return DottedBorderRenderObject(borderType: borderType);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant DottedBorderRenderObject renderObject,
  ) {
    renderObject.borderType = borderType;
  }
}

class DottedBorderRenderObject extends RenderProxyBox {
  BorderType _borderType;

  DottedBorderRenderObject({required BorderType borderType})
    : _borderType = borderType;

  set borderType(BorderType value) {
    if (value == _borderType) return;
    _borderType = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _borderType.paint(context.canvas, size, offset);

    super.paint(context, offset);
  }
}
