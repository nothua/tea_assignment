import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tea_assignment/shared/widgets/custom_switch.dart';

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
        Icon(
          Icons.notifications_none_outlined,
          color: Colors.grey[500],
          size: 24.sp,
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            notificationTime,
            style: TextStyle(
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 20.sp),
        SizedBox(width: 10.w),
        CustomSwitch(value: isEnabled, onChanged: onToggle),
      ],
    );
  }
}
