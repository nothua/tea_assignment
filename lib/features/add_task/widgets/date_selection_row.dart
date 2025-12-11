import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';

import 'package:tea_assignment/shared/widgets/circle_icon_button.dart';

import 'package:flutter_svg/flutter_svg.dart';

class DateSelectionRow extends StatelessWidget {
  final String date;
  final String? time;
  final VoidCallback? onDateTap;
  final VoidCallback? onTimeTap;
  final VoidCallback? onRepeatTap;

  const DateSelectionRow({
    super.key,
    required this.date,
    this.time,
    this.onDateTap,
    this.onTimeTap,
    this.onRepeatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/icons/calender.svg",
          colorFilter: const ColorFilter.mode(
            Color(0xFF8E8E93),
            BlendMode.srcIn,
          ),
          width: 18.sp,
          height: 18.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          "*",
          style: TextStyle(color: AppColors.iconRed, fontSize: 12.sp),
        ),
        SizedBox(width: 4.w),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: const Color(0xFF12112B),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(";", style: TextStyle(color: Colors.grey[400])),
                SizedBox(width: 8.w),
                Text(
                  time ?? "hh:mm AM",
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFAEAEB2),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 8.w),
        CircleIconButton(
          svgIcon: "assets/images/icons/alarm.svg",
          size: 34.w,
          iconSize: 18.sp,
          color: AppColors.greyF7,
          iconColor: const Color(0xFF8E8E93),
          onTap: onTimeTap,
          boxShadow: const [],
        ),
        SizedBox(width: 8.w),
        CircleIconButton(
          svgIcon: "assets/images/icons/refresh-2.svg",
          size: 34.w,
          iconSize: 18.sp,
          color: AppColors.greyF7,
          iconColor: Colors.grey[400],
          onTap: onRepeatTap,
          boxShadow: const [],
        ),
      ],
    );
  }
}
