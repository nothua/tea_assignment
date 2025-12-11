import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CircleIconButton extends StatelessWidget {
  final IconData? icon;
  final String? svgIcon;
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
    this.icon,
    this.svgIcon,
    this.onTap,
    this.size,
    this.iconSize,
    this.color,
    this.iconColor,
    this.boxShadow,
    this.border,
    this.gradient,
  }) : assert(
         icon != null || svgIcon != null,
         'Either icon or svgIcon must be provided',
       );

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
          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: AppColors.primaryPurple.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
        ),
        child: Center(
          child: svgIcon != null
              ? SvgPicture.asset(
                  svgIcon!,
                  colorFilter: iconColor != null
                      ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                      : null,
                  width: iconSize ?? 24.sp,
                  height: iconSize ?? 24.sp,
                )
              : Icon(
                  icon,
                  color: iconColor ?? AppColors.choiceChipSelected,
                  size: iconSize ?? 24.sp,
                ),
        ),
      ),
    );
  }
}
