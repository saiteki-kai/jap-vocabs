import 'package:flutter/material.dart';

class MD2Indicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double horizontalPadding;

  const MD2Indicator({
    @required this.indicatorHeight,
    @required this.indicatorColor,
    this.horizontalPadding = 0,
  });

  @override
  _MD2Painter createBoxPainter([VoidCallback onChanged]) {
    return _MD2Painter(this, onChanged);
  }
}

class _MD2Painter extends BoxPainter {
  final MD2Indicator decoration;

  _MD2Painter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    var rect = Offset(
          offset.dx - decoration.horizontalPadding / 2,
          (configuration.size.height - decoration.indicatorHeight ?? 3),
        ) &
        Size(
          configuration.size.width + decoration.horizontalPadding,
          decoration.indicatorHeight ?? 3,
        );

    final paint = Paint();
    paint.color = decoration.indicatorColor ?? Color(0xff1967d2);
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topRight: Radius.circular(8),
        topLeft: Radius.circular(8),
      ),
      paint,
    );
  }
}
