import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.icon,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.badgePaddingHorizontal,
        vertical: AppDimensions.badgePaddingVertical,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.badgeBorderRadius),
        border: Border.all(
          color: borderColor ?? AppColors.focusBadgeBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.sp,
            color: iconColor ?? AppColors.focusBadgeIcon,
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Roboto Flex',
              fontSize: 8.sp,
              color: textColor ?? AppColors.focusBadgeText,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
