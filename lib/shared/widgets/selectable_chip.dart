import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final bool showCheckmark;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.showCheckmark = false,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (selectedColor ?? AppColors.choiceChipBackground)
              : (unselectedColor ?? AppColors.greyF7),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showCheckmark && isSelected) ...[
              Icon(
                Icons.check,
                size: 16.sp,
                color: selectedTextColor ?? AppColors.choiceChipSelected,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                color: isSelected
                    ? (selectedTextColor ?? AppColors.choiceChipSelected)
                    : (unselectedTextColor ?? AppColors.textGrey),
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: fontSize ?? 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
