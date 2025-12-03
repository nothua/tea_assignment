import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/active_task/widgets/circular_progress_arc.dart';
import 'package:tea_assignment/features/active_task/widgets/circular_timer_dimensions.dart';
import 'package:tea_assignment/features/active_task/widgets/side_slider_indicator.dart';
import 'package:tea_assignment/features/active_task/widgets/timer_display.dart';

class CircularTimer extends StatelessWidget {
  final double progress;
  final String timeRemaining;
  final double leftSliderValue;
  final double rightSliderValue;
  final String leftSliderLabel;
  final String rightSliderLabel;
  final double size;
  final ValueChanged<double>? onLeftSliderChanged;
  final ValueChanged<double>? onRightSliderChanged;
  final Color? progressColor;
  final Color? leftSliderColor;
  final Color? rightSliderColor;
  final bool slidersEnabled;
  final double progressStrokeWidth;
  final bool showTicks;
  final bool disabled;

  const CircularTimer({
    super.key,
    required this.progress,
    required this.timeRemaining,
    this.leftSliderValue = 0.0,
    this.rightSliderValue = 0.0,
    this.leftSliderLabel = 'Left',
    this.rightSliderLabel = 'Right',
    this.size = 360.0,
    this.onLeftSliderChanged,
    this.onRightSliderChanged,
    this.progressColor,
    this.leftSliderColor,
    this.rightSliderColor,
    this.slidersEnabled = true,
    this.progressStrokeWidth = 16.0,
    this.showTicks = true,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final dims = CircularTimerDimensions(size);
    final widgetSize = dims.width;
    final effectiveLeftSliderColor = leftSliderColor ?? AppColors.enjoymentColor;
    final effectiveRightSliderColor = rightSliderColor ?? AppColors.purposeColor;

    return GestureDetector(
      
      onPanStart: slidersEnabled ? (d) => _handlePan(d.localPosition, dims) : null,
      onPanUpdate: slidersEnabled ? (d) => _handlePan(d.localPosition, dims) : null,
      onTapDown: slidersEnabled ? (d) => _handlePan(d.localPosition, dims) : null,
      child: Container(
        width: widgetSize,
        height: widgetSize,
        color: Colors.transparent, 
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressArc(
              progress: progress,
              size: size,
              strokeWidth: progressStrokeWidth,
              startColor: AppColors.timerProgressStart,
              endColor: AppColors.timerProgressEnd,
              showTicks: showTicks,
              radius: dims.progressRadius,
              sliderBgRadius: dims.sliderBgRadius,
              innerCircleRadius: dims.innerCircleRadius,
              disabled: disabled,
            ),
            TimerDisplay(
              timeRemaining: timeRemaining,
            ),
            
            
            
            SideSliderIndicator(
              label: rightSliderLabel,
              value: rightSliderValue,
              color: effectiveRightSliderColor,
              isLeft: false, 
              size: Size(widgetSize, widgetSize),
              radius: dims.rightSliderRadius,
              textOffset: dims.textOffset,
              
            ),
            SideSliderIndicator(
              label: leftSliderLabel,
              value: leftSliderValue,
              color: effectiveLeftSliderColor,
              isLeft: true, 
              size: Size(widgetSize, widgetSize),
              radius: dims.leftSliderRadius,
              textOffset: dims.textOffset,
            ),
          ],
        ),
      ),
    );
  }

  void _handlePan(Offset localPos, CircularTimerDimensions dims) {
    final center = dims.center;
    final dx = localPos.dx - center;
    final dy = localPos.dy - center;
    
    final dist = math.sqrt(dx * dx + dy * dy);
    final validRadius = dims.leftSliderRadius; 
    if (dist < validRadius - 40.w || dist > validRadius + 40.w) {
      return;
    }
    
    final isLeft = dx < 0;

    if (isLeft) {
      if (onLeftSliderChanged == null) return;
      
      final angle = math.atan2(dy, -dx); 
      _processSliderChange(angle, onLeftSliderChanged!);
    } else {
      if (onRightSliderChanged == null) return;
      
      final angle = math.atan2(dy, dx);
      _processSliderChange(angle, onRightSliderChanged!);
    }
  }

  void _processSliderChange(double angleRad, ValueChanged<double> onChanged) {
    const startAngleRad = 27 * math.pi / 180;
    const endAngleRad = -27 * math.pi / 180;
    const totalSweep = startAngleRad - endAngleRad; 

    double progress = (startAngleRad - angleRad) / totalSweep;

    if (progress < -0.1 || progress > 1.1) return; 
    
    progress = progress.clamp(0.0, 1.0);
    onChanged(progress);
  }
}