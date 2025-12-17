import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompactTaskItem extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CompactTaskItem({
    super.key,
    required this.title,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE5E5EA), width: 1),
        ),
        child: Row(
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 16.sp, // Slightly larger font
                fontWeight: FontWeight.w500, // Slightly bolder
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const Spacer(),
            // Duration (No chip, just icon and text)
            SvgPicture.asset(
              "assets/images/icons/clock.svg",
              width: 16.sp,
              height: 16.sp,
              colorFilter: const ColorFilter.mode(
                Color(0xFF8E8E93),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              "hh:mm", // Placeholder or from duration
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 14.sp,
                color: const Color(0xFF8E8E93),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
