import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class TaskMetadataRow extends StatelessWidget {
  final String startTime;
  final String duration;

  const TaskMetadataRow({
    super.key,
    required this.startTime,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
        SizedBox(width: 4.w),
        Text(
          startTime,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 16.w),
        Icon(Icons.timer_outlined, size: 16.sp, color: Colors.grey),
        SizedBox(width: 4.w),
        Text(
          duration,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
