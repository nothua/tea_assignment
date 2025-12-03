import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';

class CircularProgressArc extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color startColor;
  final Color endColor;
  final bool showTicks;
  final Color tickColor;
  final double tickOpacity;
  final double? radius;
  final double? sliderBgRadius;
  final double? innerCircleRadius;
  final bool disabled;

  const CircularProgressArc({
    super.key,
    required this.progress,
    this.size = 360.0,
    this.strokeWidth = 16.0,
    this.startColor = AppColors.timerProgressStart,
    this.endColor = AppColors.timerProgressEnd,
    this.showTicks = true,
    this.tickColor = Colors.grey,
    this.tickOpacity = 0.2,
    this.radius,
    this.sliderBgRadius,
    this.innerCircleRadius,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size.w, size.w),
      painter: _CircularProgressPainter(
        progress: progress,
        strokeWidth: strokeWidth,
        startColor: startColor,
        endColor: endColor,
        showTicks: showTicks,
        tickColor: tickColor,
        tickOpacity: tickOpacity,
        radius: radius ?? 131.4.w,
        sliderBgRadius: sliderBgRadius ?? 136.w,
        innerCircleRadius: innerCircleRadius ?? 104.w,
        disabled: disabled,
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color startColor;
  final Color endColor;
  final bool showTicks;
  final Color tickColor;
  final double tickOpacity;
  final double radius;
  final double sliderBgRadius;
  final double innerCircleRadius;
  final bool disabled;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.startColor,
    required this.endColor,
    required this.showTicks,
    required this.tickColor,
    required this.tickOpacity,
    required this.radius,
    required this.sliderBgRadius,
    required this.innerCircleRadius,
    required this.disabled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    canvas.drawCircle(
      center,
      sliderBgRadius + 2.w,
      Paint()
        ..color = AppColors.timerInnerShadow.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15),
    );
    
    canvas.drawCircle(
      center,
      sliderBgRadius,
      Paint()
        ..color = AppColors.whiteColor
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      center,
      innerCircleRadius + 2.w,
      Paint()
        ..color = AppColors.timerInnerShadow.withValues(alpha: 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15),
    );
    
    final innerGradient = RadialGradient(
      colors: const [
        Color(0xFFE9E9F7),
        Color(0xFFFFFFFF),
      ],
      stops: const [0.0, 0.75],
    );
    
    canvas.drawCircle(
      center,
      innerCircleRadius,
      Paint()
        ..shader = innerGradient.createShader(
          Rect.fromCircle(center: center, radius: innerCircleRadius),
        )
    );

    final backgroundGradient = SweepGradient(
      colors: [
        AppColors.timerBackgroundGradientStart.withValues(alpha: 0.1),
        AppColors.timerBackgroundGradientEnd.withValues(alpha: 0.1),
      ],
      stops: const [0.0, 1.0],
    );

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = backgroundGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, backgroundPaint);


    if (showTicks) {
      final tickPaint = Paint()
        ..color = tickColor.withValues(alpha: tickOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      for (int i = 0; i < 180; i++) {
        final angle = (i * 2) * math.pi / 180;
        final startPoint = Offset(
          center.dx + (radius - 6) * math.cos(angle),
          center.dy + (radius - 6) * math.sin(angle),
        );
        final endPoint = Offset(
          center.dx + (radius + 4) * math.cos(angle),
          center.dy + (radius + 4)* math.sin(angle),
        );
        canvas.drawLine(startPoint, endPoint, tickPaint);
      }
    }

    if (progress <= 0 && !disabled) return;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-math.pi / 2);

    final double sweepAngle = progress * 2 * math.pi;

    if (disabled) {
      final disabledPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt
        ..color = const Color(0xFFC5C4F1);

      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: radius),
        0,
        sweepAngle,
        false,
        disabledPaint,
      );
      
      final thumbX = radius * math.cos(sweepAngle);
      final thumbY = radius * math.sin(sweepAngle);
      final thumbCenter = Offset(thumbX, thumbY);

      canvas.drawCircle(
        thumbCenter,
        strokeWidth / 2,
        Paint()..color = const Color(0xFFC5C4F1),
      );

      final startThumbCenter = Offset(radius, 0);
      canvas.drawCircle(
        startThumbCenter,
        strokeWidth / 2,
        Paint()..color = const Color(0xFFC5C4F1),
      );

      canvas.restore();
      return;
    }

    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: sweepAngle,
      tileMode: TileMode.clamp,
      colors: const [
        Color(0xFF7C7AFF),
        Color(0xFF1B1A5F),
      ],
      stops: const [0.0, 0.49],
    );

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..shader = gradient.createShader(
        Rect.fromCircle(center: Offset.zero, radius: radius),
      );

    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: radius),
      0,
      sweepAngle,
      false,
      progressPaint,
    );

    final thumbX = radius * math.cos(sweepAngle);
    final thumbY = radius * math.sin(sweepAngle);
    final thumbCenter = Offset(thumbX, thumbY);

    canvas.drawCircle(
      thumbCenter,
      strokeWidth / 2,
      Paint()..color = const Color(0xFF1B1A5F),
    );

    final startThumbCenter = Offset(radius, 0);

    canvas.drawCircle(
      startThumbCenter,
      strokeWidth / 2,
      Paint()..color = const Color(0xFF7C7AFF),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.startColor != startColor ||
      oldDelegate.endColor != endColor ||
      oldDelegate.radius != radius ||
      oldDelegate.sliderBgRadius != sliderBgRadius ||
      oldDelegate.innerCircleRadius != innerCircleRadius;
}
