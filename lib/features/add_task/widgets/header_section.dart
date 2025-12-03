import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: "Name your task",
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 18.sp, fontWeight: FontWeight.w500),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 0, left: 0),
                child: Text("*", style: TextStyle(color: Colors.red, fontSize: 20.sp)),
              ),
              suffixIconConstraints: const BoxConstraints(minWidth: 15, minHeight: 0),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEFE9),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Container(
                width: 6.w, height: 6.w,
                decoration: const BoxDecoration(color: Color(0xFFFF6F42), shape: BoxShape.circle),
              ),
              SizedBox(width: 6.w),
              Text(
                "Open",
                style: TextStyle(color: const Color(0xFFFF6F42), fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.keyboard_arrow_down, size: 16.sp, color: const Color(0xFFFF6F42))
            ],
          ),
        )
      ],
    );
  }
}
