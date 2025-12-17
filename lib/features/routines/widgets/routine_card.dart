import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';

class RoutineCard extends StatelessWidget {
  final String title;
  final String startTime;
  final String endTime;
  final String frequency;
  final String iconAsset;
  final Color iconColor;
  final Color iconBackgroundColor;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final bool showExpandIcon;

  const RoutineCard({
    super.key,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.frequency,
    required this.iconAsset,
    required this.iconColor,
    required this.iconBackgroundColor,
    this.onTap,
    this.onEdit,
    this.showExpandIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Box
            Container(
              width: 48.w,
              height: 48.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                iconAsset,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
            SizedBox(width: 12.w),
            // Middle Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/clock.svg',
                        width: 14.sp,
                        height: 14.sp,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF6B6B6B),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        startTime,
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6B6B6B),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SvgPicture.asset(
                        'assets/images/icons/clock.svg',
                        width: 14.sp,
                        height: 14.sp,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF6B6B6B),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        endTime,
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6B6B6B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Right Side
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Alarm Icon (Placeholder for now, based on image)
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F0FF), // Light purple bg for alarm
                    shape: BoxShape.circle,
                  ),
                  // Using a timer or alarm icon
                  child: Center(
                    child: Icon(
                      Icons.timer_outlined, // Or specific asset if available
                      size: 14.sp,
                      color: const Color(0xFFD1C4E9),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/repeat.svg',
                      width: 14.sp,
                      height: 14.sp,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF6B6B6B),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      frequency,
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B6B6B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
