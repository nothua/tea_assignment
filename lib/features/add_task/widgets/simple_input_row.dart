import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleInputRow extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;

  const SimpleInputRow({
    super.key,
    required this.icon,
    required this.hint,
    required this.actionLabel,
    this.actionIcon,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[500], size: 18.sp),
        SizedBox(width: 16.w),
        Text(
          hint,
          style: TextStyle(
            fontFamily: 'Roboto Flex',
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onActionTap,
          child: Row(
            children: [
              if (actionIcon != null)
                Icon(actionIcon, size: 16.sp, color: Colors.blue[600]),
              if (actionIcon != null) SizedBox(width: 4.w),
              Text(
                actionLabel,
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
