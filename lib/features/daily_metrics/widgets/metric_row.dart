import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class MetricRow extends StatelessWidget {
  final String label;
  final String time;
  final String percentage;
  final Color color;
  final double progress;

  const MetricRow({
    super.key,
    required this.label,
    required this.time,
    required this.percentage,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.metricRowPaddingBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppDimensions.metricRowProgressBarHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.greyF2, 
              borderRadius: BorderRadius.circular(AppDimensions.metricRowBorderRadius),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(AppDimensions.metricRowBorderRadius),
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.metricRowGap),
          // Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: AppDimensions.metricRowLabelFontSize,
                    color: AppColors.textDarkBlue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                time,
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: AppDimensions.metricRowValueFontSize,
                  color: color,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                width: 32.w,
                child: Text(
                  percentage,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: AppDimensions.metricRowValueFontSize,
                    color: AppColors.textDarkBlue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
