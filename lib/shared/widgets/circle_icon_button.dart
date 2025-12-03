import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double? size;
  final double? iconSize;
  final Color? color;
  final Color? iconColor;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final Gradient? gradient;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size,
    this.iconSize,
    this.color,
    this.iconColor,
    this.boxShadow,
    this.border,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size ?? AppDimensions.circleButtonSizeMedium,
        height: size ?? AppDimensions.circleButtonSizeMedium,
        decoration: BoxDecoration(
          color: color ?? AppColors.whiteColor,
          shape: BoxShape.circle,
          gradient: gradient,
          border: border,
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.choiceChipSelected,
          size: iconSize ?? 24.sp,
        ),
      ),
    );
  }
}
