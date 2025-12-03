import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? trailing;
  final Color? titleColor;

  const AppHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.trailing,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.headerHorizontalPadding,
        vertical: AppDimensions.headerVerticalPadding,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 18.sp),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
                color: AppColors.textPrimary,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              if (trailing != null)
                Row(
                  children: trailing!,
                ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto Flex',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: titleColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
