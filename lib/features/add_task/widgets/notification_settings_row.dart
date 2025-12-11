import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tea_assignment/shared/widgets/custom_switch.dart';

import 'package:flutter_svg/flutter_svg.dart';

class NotificationSettingsRow extends StatelessWidget {
  final String notificationTime;
  final bool isEnabled;
  final Function(bool) onToggle;
  final VoidCallback? onTimeTap;

  const NotificationSettingsRow({
    super.key,
    required this.notificationTime,
    required this.isEnabled,
    required this.onToggle,
    this.onTimeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/icons/notification.svg",
          colorFilter: const ColorFilter.mode(
            Color(0xFF8E8E93),
            BlendMode.srcIn,
          ),
          width: 18.sp,
          height: 18.sp,
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: GestureDetector(
            onTap: onTimeTap,
            child: Row(
              children: [
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
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        CustomSwitch(value: isEnabled, onChanged: onToggle),
      ],
    );
  }
}
