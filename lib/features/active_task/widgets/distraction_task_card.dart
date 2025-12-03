import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';

class DistractionTaskCard extends StatelessWidget {
  final String title;
  final String duration;
  final String dateTime;
  final bool isOpen;

  const DistractionTaskCard({
    super.key,
    required this.title,
    required this.duration,
    required this.dateTime,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF12112B),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.distractionOpenBg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6337),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Open',
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 10.sp,
                        color: const Color(0xFFFF6337),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildInfoChip(Icons.access_time, duration, fontWeight: FontWeight.bold),
              SizedBox(width: 12.w),
              _buildInfoChip(Icons.calendar_today, dateTime),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, {FontWeight fontWeight = FontWeight.w400}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: const Color(0xFF636366)),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Roboto Flex',
              fontSize: 8.sp,
              fontWeight: fontWeight,
              color: const Color(0xFF636366),
            ),
          ),
        ],
      ),
    );
  }
}
