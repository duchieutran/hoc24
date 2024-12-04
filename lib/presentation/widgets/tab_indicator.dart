import 'package:flutter/material.dart';

class TabIndicator extends Decoration {
  final Color color;
  final double radius;

  const TabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset =
        Offset(configuration.size!.width / 2 - radius / 2, configuration.size!.height - 2 * radius);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
