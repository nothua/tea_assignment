import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParentTaskIndicator extends StatelessWidget {
  final String parentTitle;

  const ParentTaskIndicator({super.key, required this.parentTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.subdirectory_arrow_right,
            color: const Color(0xFF8E8E93),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Parent Task",
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 10.sp,
                    color: const Color(0xFF8E8E93),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  parentTitle,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 14.sp,
                    color: const Color(0xFF12112B),
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
