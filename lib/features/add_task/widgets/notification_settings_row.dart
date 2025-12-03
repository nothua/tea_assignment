import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class NotificationSettingsRow extends StatelessWidget {
  final String notificationTime;
  final bool isEnabled;
  final Function(bool) onToggle;

  const NotificationSettingsRow({
    super.key,
    required this.notificationTime,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.notifications_none_outlined, color: Colors.grey[500], size: 24.sp),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            notificationTime,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 20.sp),
        SizedBox(width: 10.w),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: isEnabled,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF2ECC71),
            onChanged: onToggle,
          ),
        ),
      ],
    );
  }
}
