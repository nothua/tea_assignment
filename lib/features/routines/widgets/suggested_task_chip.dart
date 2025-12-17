import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestedTaskChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isAddButton;
  final bool isSelected;

  const SuggestedTaskChip({
    super.key,
    required this.label,
    this.onTap,
    this.isAddButton = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2196F3) : Colors.white,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2196F3)
                : const Color(0xFFE0E0E0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF333333),
              ),
            ),
            if (!isSelected) ...[
              SizedBox(width: 8.w),
              Icon(Icons.add, size: 18.sp, color: const Color(0xFF2196F3)),
            ],
          ],
        ),
      ),
    );
  }
}
