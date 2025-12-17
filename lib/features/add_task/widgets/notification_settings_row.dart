import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/shared/widgets/circle_icon_button.dart';
import 'package:tea_assignment/shared/widgets/custom_switch.dart';

class NotificationSettingsRow extends StatelessWidget {
  final String notificationTime;
  final bool isEnabled;
  final Function(bool) onToggle;
  final VoidCallback? onTimeTap;
  final bool useSwitch;

  const NotificationSettingsRow({
    super.key,
    required this.notificationTime,
    required this.isEnabled,
    required this.onToggle,
    this.useSwitch = false,
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
                      fontWeight: FontWeight.w400, // Changed to w400
                      fontSize: 14.sp,
                      color: const Color(
                        0xFF8E8E93,
                      ), // Changed color to match design
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF8E8E93),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (useSwitch)
              CustomSwitch(value: isEnabled, onChanged: onToggle)
            else
              CircleIconButton(
                svgIcon: isEnabled
                    ? "assets/images/icons/notification_alarm.svg"
                    : "assets/images/icons/no_notification_alarm.svg",
                size: 34.w,
                iconSize: 18.sp,
                color: isEnabled
                    ? const Color(0xFFE0E0F6)
                    : AppColors
                          .greyF7, // Usually purple bg when active? Or just F7
                // The design shows green toggle, but Routine screen requested circle button.
                // Assuming Circle Button style:
                iconColor: isEnabled
                    ? const Color(0xFF5F5FBC)
                    : const Color(0xFF8E8E93), // Use brand colors or grey
                onTap: () => onToggle(!isEnabled),
                boxShadow: const [],
              ),
          ],
        ),
      ],
    );
  }
}
