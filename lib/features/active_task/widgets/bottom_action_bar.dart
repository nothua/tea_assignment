import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/shared/widgets/circle_icon_button.dart';

class BottomActionBar extends StatelessWidget {
  final VoidCallback? onStopTap;
  final VoidCallback? onDistractionTap;
  final bool isPlaying;
  final bool isDistractionActive;
  final String distractionElapsedTime;

  const BottomActionBar({
    super.key,
    this.onStopTap,
    this.onDistractionTap,
    this.isPlaying = false,
    this.isDistractionActive = false,
    this.distractionElapsedTime = '00:00',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.bottomBarPaddingHorizontal,
        vertical: AppDimensions.bottomBarPaddingVertical,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: isPlaying ? 0.5 : 1.0,
              child: CircleIconButton(
                icon: Icons.stop,
                size: AppDimensions.circleButtonSizeSmall,
                iconSize: 12.sp,
                color: AppColors.greyF2,
                iconColor: AppColors.greyC7,
                onTap: isPlaying ? null : onStopTap,
                boxShadow: const [],
              ),
            ),
            GestureDetector(
              onTap: onDistractionTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isDistractionActive ? AppColors.distractionOpenBg : AppColors.greyF7,
                  borderRadius: BorderRadius.circular(AppDimensions.distractionButtonRadius),
                ),
                child: Row(
                  children: [
                    Icon(
                      isDistractionActive ? Icons.stop : Icons.add,
                      size: 16.sp,
                      color: isDistractionActive ? const Color(0xFFFF6337) : AppColors.grey8E,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      isDistractionActive ? distractionElapsedTime : 'Distraction',
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: isDistractionActive ? const Color(0xFFFF6337) : AppColors.grey8E,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
