import 'package:flutter/material.dart';

class SlimTickMarkShape extends SliderTickMarkShape {
  final double tickMarkWidth;

  const SlimTickMarkShape({this.tickMarkWidth = 2.0});

  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    required bool isEnabled,
  }) {
    return Size(tickMarkWidth, sliderTheme.trackHeight!);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    required bool isEnabled,
  }) {
    final Paint paint = Paint()
      ..color = sliderTheme.inactiveTickMarkColor!
      ..strokeWidth = tickMarkWidth
      ..style = PaintingStyle.stroke;

    const double epsilon = 0.5;
    final double trackStart = 0.0;
    final double trackEnd = parentBox.size.width;

    if ((center.dx - trackStart).abs() < epsilon ||
        (center.dx - trackEnd).abs() < epsilon) {
      return;
    }

    context.canvas.drawLine(
      Offset(center.dx, center.dy - sliderTheme.trackHeight! / 2),
      Offset(center.dx, center.dy + sliderTheme.trackHeight! / 2),
      paint,
    );
  }
}
