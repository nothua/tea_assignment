import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/features/add_task/widgets/status_selector.dart';

class HeaderSection extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool showStatusSelector;

  const HeaderSection({
    super.key,
    this.hintText = "Name your task",
    this.controller,
    this.showStatusSelector = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 4.w, top: 4.h),
          child: Text(
            "*",
            style: TextStyle(color: const Color(0xFFFF3B30), fontSize: 12.sp),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller, // Added controller
            style: TextStyle(
              fontFamily: 'Roboto Flex',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFAEAEB2),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: 'Roboto Flex',
                color: const Color(0xFFAEAEB2),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        if (showStatusSelector) ...[
          SizedBox(width: 8.w),
          StatusSelector(onStatusChanged: (status) {}),
        ],
      ],
    );
  }
}
