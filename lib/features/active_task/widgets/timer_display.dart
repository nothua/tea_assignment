import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class TimerDisplay extends StatelessWidget {
  final String timeRemaining;
  final TextStyle? timeStyle;
  final TextStyle? labelStyle;
  final String label;

  const TimerDisplay({
    super.key,
    required this.timeRemaining,
    this.timeStyle,
    this.labelStyle,
    this.label = 'Time Remaining',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeRemaining,
          style: timeStyle ??
              TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: AppDimensions.timerTimeFontSize,
                fontWeight: FontWeight.w600, 
                color: AppColors.timerTimeText,
              ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: labelStyle ??
              TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: AppDimensions.timerLabelFontSize,
                fontWeight: FontWeight.w400, 
                color: AppColors.timerLabelText,
              ),
        ),
      ],
    );
  }
}
