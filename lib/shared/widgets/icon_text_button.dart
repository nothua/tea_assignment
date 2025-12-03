import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final double? iconSize;
  final double? fontSize;
  final bool isIconLeading;

  const IconTextButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.color,
    this.iconSize,
    this.fontSize,
    this.isIconLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = [
      Icon(
        icon,
        size: iconSize ?? 16.sp,
        color: color ?? Colors.blue[600],
      ),
      SizedBox(width: isIconLeading ? 4.w : 2.w),
      Text(
        label,
        style: TextStyle(
          color: color ?? Colors.blue[600],
          fontSize: fontSize ?? 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: isIconLeading ? content : content.reversed.toList(),
      ),
    );
  }
}
