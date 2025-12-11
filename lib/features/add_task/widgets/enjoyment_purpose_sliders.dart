import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnjoymentPurposeSliders extends StatelessWidget {
  final String enjoymentLabel;
  final String purposeLabel;
  final VoidCallback? onEnjoymentTap;
  final VoidCallback? onPurposeTap;

  const EnjoymentPurposeSliders({
    super.key,
    required this.enjoymentLabel,
    required this.purposeLabel,
    this.onEnjoymentTap,
    this.onPurposeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Enjoyment",
                    style: TextStyle(
                      fontFamily: 'Roboto Flex',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.help_outline,
                    size: 14.sp,
                    color: Colors.grey[500],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              _sliderContainer(
                label: enjoymentLabel,
                bgColor: const Color(0xFFFFE0D6),
                textColor: const Color(0xFFFF6F42),
                onTap: onEnjoymentTap,
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Purpose",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.help_outline,
                    size: 14.sp,
                    color: Colors.grey[500],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              _sliderContainer(
                label: purposeLabel,
                bgColor: const Color(0xFFD6E4FF),
                textColor: const Color(0xFF2B75FF),
                onTap: onPurposeTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sliderContainer({
    required String label,
    required Color bgColor,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Icon(Icons.tune, color: Colors.grey[500], size: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
