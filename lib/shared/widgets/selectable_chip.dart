import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
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
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? (selectedTextColor ?? AppColors.choiceChipSelected)
                : (unselectedTextColor ?? AppColors.textGrey),
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
