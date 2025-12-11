import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/features/add_task/widgets/status_selector.dart';

class HeaderSection extends StatelessWidget {
  final String hintText;

  const HeaderSection({super.key, this.hintText = "Name your task"});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
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
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 0, left: 0),
                child: Text(
                  "*",
                  style: TextStyle(
                    color: const Color(0xFFFF3B30),
                    fontSize: 12.sp,
                  ),
                ),
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 15,
                minHeight: 0,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        StatusSelector(
          onStatusChanged: (status) {
            // Handle status change if needed, or expose callback
          },
        ),
      ],
    );
  }
}
