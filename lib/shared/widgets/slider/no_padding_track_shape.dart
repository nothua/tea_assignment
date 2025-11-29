import 'package:flutter/material.dart';

class NoPaddingTrackShape extends RoundedRectSliderTrackShape {
  final int? divisions;
  final bool hideEdgeTicks;

  const NoPaddingTrackShape({
    this.divisions,
    this.hideEdgeTicks = false,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      secondaryOffset: secondaryOffset,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
      additionalActiveTrackHeight: additionalActiveTrackHeight,
    );

    if (divisions == null || divisions! <= 0) return;

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final double tickInterval = trackRect.width / divisions!;
    final Paint paint = Paint()
      ..strokeWidth = 2.0 
      ..style = PaintingStyle.stroke;

    for (int i = 0; i <= divisions!; i++) {
      if (hideEdgeTicks && (i == 0 || i == divisions!)) continue;

      final double x = trackRect.left + i * tickInterval;
      final Offset tickCenter = Offset(x, trackRect.center.dy);

      if (x < thumbCenter.dx) {
        paint.color = sliderTheme.activeTickMarkColor ?? Colors.transparent;
      } else {
        paint.color = sliderTheme.inactiveTickMarkColor ?? Colors.white;
      }

      context.canvas.drawLine(
        Offset(tickCenter.dx, tickCenter.dy - trackRect.height / 2),
        Offset(tickCenter.dx, tickCenter.dy + trackRect.height / 2),
        paint,
      );
    }
  }
}
