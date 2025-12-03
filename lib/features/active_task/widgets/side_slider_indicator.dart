import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SideSliderIndicator extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final bool isLeft;
  final Size size;
  final double? radius;
  final double sweepDegrees;
  final double textOffset;
  final double strokeWidth;
  final bool enabled; 

  const SideSliderIndicator({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.isLeft,
    required this.size,
    this.radius,
    this.sweepDegrees = 54.0,
    this.textOffset = 11.0,
    this.strokeWidth = 6.0,
    this.enabled = true, 
  });

  @override
  Widget build(BuildContext context) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = radius ?? (136.w + 22.5.w);
    final sweepRad = sweepDegrees * math.pi / 180.0;
    
    final path = Path();
    if (isLeft) {
      path.addArc(
        Rect.fromCircle(center: center, radius: r),
        (180 - 27) * math.pi / 180.0,
        sweepRad,
      );
    } else {
      path.addArc(
        Rect.fromCircle(center: center, radius: r),
        27 * math.pi / 180.0,
        -sweepRad,
      );
    }

    final metrics = path.computeMetrics().first;
    final offset = metrics.length * value;
    final tangent = metrics.getTangentForOffset(offset);
    final iconPos = tangent?.position ?? center;

    return IgnorePointer(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            CustomPaint(
              size: size,
              painter: _SideSliderPainter(
                value: value,
                color: enabled ? color : color.withOpacity(0.5), 
                path: path,
                label: label,
                isLeft: isLeft,
                radius: r + textOffset,
                strokeWidth: strokeWidth,
              ),
            ),
            Positioned(
              top: iconPos.dy - 16.w,
              left: iconPos.dx - 16.w,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.menu,
                  size: 16.sp,
                  
                  color: enabled ? Colors.grey : Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideSliderPainter extends CustomPainter {
  final double value;
  final Color color;
  final Path path;
  final String label;
  final bool isLeft;
  final double radius;
  final double strokeWidth;

  _SideSliderPainter({
    required this.value,
    required this.color,
    required this.path,
    required this.label,
    required this.isLeft,
    required this.radius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    
    paint.color = Colors.grey.withOpacity(0.2);
    canvas.drawPath(path, paint);

    
    final metrics = path.computeMetrics().first;
    final length = metrics.length;
    final endOffset = length * value;

    if (endOffset > 0) {
      final activePath = metrics.extractPath(0, endOffset);
      paint.color = color;
      canvas.drawPath(activePath, paint);
    }

    _drawCircularText(canvas, size);
  }

  void _drawCircularText(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final textStyle = TextStyle(
      fontFamily: 'Inter',
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    );

    final double charAngleStep = 3.0 * math.pi / 180.0;
    final double totalAngle = (label.length - 1) * charAngleStep;

    double startAngle;
    double angleStep;

    if (isLeft) {
      final double bottomAngle = (180 - 27) * math.pi / 180.0;
      startAngle = bottomAngle + totalAngle;
      angleStep = -charAngleStep;
    } else {
      startAngle = 27 * math.pi / 180.0;
      angleStep = -charAngleStep;
    }

    for (int i = 0; i < label.length; i++) {
      final char = label[i];
      final charAngle = startAngle + (i * angleStep);

      final x = center.dx + radius * math.cos(charAngle);
      final y = center.dy + radius * math.sin(charAngle);

      canvas.save();
      canvas.translate(x, y);

      final rotation = charAngle - math.pi / 2;
      canvas.rotate(rotation);

      final textPainter = TextPainter(
        text: TextSpan(text: char, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _SideSliderPainter oldDelegate) =>
      oldDelegate.value != value || oldDelegate.color != color;
}