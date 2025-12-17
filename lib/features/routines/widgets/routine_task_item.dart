import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoutineTaskItem extends StatelessWidget {
  final String title;
  final String? date;
  final String? time;
  final String duration;
  final Color color;
  final bool isCompleted;
  final bool isDetailed;
  final int? index;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;
  final bool showDivider; // Add showDivider

  const RoutineTaskItem({
    super.key,
    required this.title,
    this.date,
    this.time,
    required this.duration,
    required this.color,
    this.isCompleted = false,
    this.isDetailed = false,
    this.index,
    this.isChecked = false,
    this.onChanged,
    this.showDivider = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: showDivider
            ? Border(
                bottom: BorderSide(color: const Color(0xFFF2F2F2), width: 1),
              )
            : null,
      ),
      child: Row(
        children: [
          // Leading Checkbox/Icon
          GestureDetector(
            onTap: () {
              if (onChanged != null) {
                onChanged!(!isChecked);
              }
            },
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: isChecked
                    ? const Color(0xFF7E57C2)
                    : const Color(0xFFF8F7FF),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isChecked
                      ? const Color(0xFF7E57C2)
                      : const Color(0xFFD1C4E9),
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
            ),
          ),
          SizedBox(width: 16.w),

          // Middle Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    // Time Chip
                    // Time Chip Removed
                    // SizedBox(width: 8.w), Removed

                    // Duration Chip
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(
                          100.r,
                        ), // Pill shape
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            "assets/images/icons/clock.svg",
                            width: 14.sp,
                            height: 14.sp,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF636366),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            duration,
                            style: TextStyle(
                              fontFamily: 'Roboto Flex',
                              fontSize: 8.sp,
                              color: const Color(0xFF636366),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
