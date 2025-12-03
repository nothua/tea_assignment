import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class TagChip extends StatelessWidget {
  final String label;
  final VoidCallback? onRemove;

  const TagChip({
    super.key,
    required this.label,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 6.w,
        top: 6.h,
        bottom: 6.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.greyF7,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
