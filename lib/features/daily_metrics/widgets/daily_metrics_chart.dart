import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class DailyMetricData {
  final String display;
  final String value;
  final double progress;
  final Color color;

  const DailyMetricData({
    required this.display,
    required this.value,
    required this.progress,
    required this.color,
  });
}

class DailyMetricsChart extends StatelessWidget {
  final List<DailyMetricData> outerData;
  final List<DailyMetricData> innerData;

  const DailyMetricsChart({
    super.key,
    required this.outerData,
    required this.innerData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.dailyMetricsChartSize,
      height: AppDimensions.dailyMetricsChartSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The Rings (Outer & Inner)
          CustomPaint(
            size: Size(AppDimensions.dailyMetricsChartSize, AppDimensions.dailyMetricsChartSize),
            painter: _ChartPainter(
              outerData: outerData,
              innerData: innerData,
            ),
          ),
          
          // The Center Legend
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: outerData.map((data) {
              return Padding(
                padding: EdgeInsets.only(bottom: AppDimensions.dailyMetricsLegendPadding),
                child: _LegendItem(
                  color: data.color,
                  label: data.display,
                  time: data.value,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String time;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: AppDimensions.dailyMetricsLegendCircleSize,
          height: AppDimensions.dailyMetricsLegendCircleSize,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppDimensions.dailyMetricsLegendCircleSize),
        Text(
          '$label ',
          style: TextStyle(
            fontFamily: 'Roboto Flex',
            fontSize: AppDimensions.dailyMetricsLegendFontSize,
            color: AppColors.textDarkBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontFamily: 'Roboto Flex',
            fontSize: AppDimensions.dailyMetricsLegendFontSize,
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<DailyMetricData> outerData;
  final List<DailyMetricData> innerData;

  _ChartPainter({required this.outerData, required this.innerData});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Stroke configurations
    final double outerStrokeWidth = AppDimensions.dailyMetricsOuterStrokeWidth;
    final double innerStrokeWidth = AppDimensions.dailyMetricsInnerStrokeWidth;
    final double ringGap = AppDimensions.dailyMetricsRingGap; 

    double degToRad(double deg) => deg * (pi / 180.0);

    final outerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerStrokeWidth
      ..strokeCap = StrokeCap.round;

    final outerRadius = radius - outerStrokeWidth / 2;

    outerPaint.color = AppColors.greyF2; 
    canvas.drawCircle(center, outerRadius, outerPaint);

    // Draw Segments
    final double visualGapPx = AppDimensions.dailyMetricsSegmentGap;
    final double pathGapPx = visualGapPx + outerStrokeWidth;
    final double gapRad = pathGapPx / outerRadius;
    final double gapDeg = gapRad * (180 / pi);
    
    // Assuming item.progress is a fraction of 24h (0.0 - 1.0).
    // 1.0 = Full Circle (minus gaps).
    
    double availableDeg = 360.0 - (outerData.length * gapDeg);
    if (availableDeg < 0) availableDeg = 0;
    
    double startAngleDeg = -90.0; 

    for (var item in outerData) {
      // Absolute mapping: progress * availableDeg
      double sweepDeg = item.progress * availableDeg;
      
      outerPaint.color = item.color;
      
      if (sweepDeg > 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: outerRadius),
          degToRad(startAngleDeg),
          degToRad(sweepDeg),
          false,
          outerPaint,
        );
      }
      
      startAngleDeg += sweepDeg + gapDeg;
    }

    final innerRadius = outerRadius - (outerStrokeWidth / 2) - (innerStrokeWidth / 2) - ringGap;
    
    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = innerStrokeWidth
      ..strokeCap = StrokeCap.round;

    if (innerData.isNotEmpty) {
        final double innerVisualGapPx = 4.w; 
        final double innerPathGapPx = innerVisualGapPx + innerStrokeWidth;
        final double innerGapRad = innerPathGapPx / innerRadius;
        final double innerGapDeg = innerGapRad * (180 / pi);
        
        // Each item gets an equal "slot" of potential space (360 / N).
        // 100% progress fills that slot.
        // Items are clustered together.
        
        double availableInnerDeg = 360.0 - (innerData.length * innerGapDeg);
        if (availableInnerDeg < 0) availableInnerDeg = 0;

        double maxSweepPerItem = availableInnerDeg / innerData.length;
        
        List<double> sweeps = [];
        double totalSweep = 0;
        
        for (var item in innerData) {
            double p = item.progress > 1.0 ? 1.0 : item.progress;
            if (p < 0) p = 0;
            
            double sweep = p * maxSweepPerItem;
            sweeps.add(sweep);
            totalSweep += sweep;
        }
        
        if (innerData.length > 1) {
            totalSweep += (innerData.length - 1) * innerGapDeg;
        }
        
        // Center at bottom (90 deg)
        double currentInnerAngle = 90.0 - (totalSweep / 2);
        
        for (int i = 0; i < innerData.length; i++) {
            final item = innerData[i];
            final sweep = sweeps[i];
            
            innerPaint.color = item.color;
            
            if (sweep > 0) {
              canvas.drawArc(
                  Rect.fromCircle(center: center, radius: innerRadius),
                  degToRad(currentInnerAngle),
                  degToRad(sweep),
                  false,
                  innerPaint,
              );
            }
            
            currentInnerAngle += sweep + innerGapDeg;
        }
    }

    final tickRadius = innerRadius - (innerStrokeWidth / 2) - ringGap - AppDimensions.dailyMetricsTickRadius; 
    final tickPaint = Paint()
      ..color = AppColors.tickColor
      ..style = PaintingStyle.fill;

    const tickCount = 24; 
    for (int i = 0; i < tickCount; i++) {
      final angle = -pi / 2 + (i * 2 * pi / tickCount);
      final p = Offset(
        center.dx + tickRadius * cos(angle),
        center.dy + tickRadius * sin(angle),
      );
      canvas.drawCircle(p, AppDimensions.dailyMetricsTickRadius, tickPaint); 
    }
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) {
    return oldDelegate.outerData != outerData || oldDelegate.innerData != innerData;
  }
}