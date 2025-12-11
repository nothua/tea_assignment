import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SimpleInputRow extends StatelessWidget {
  final IconData? icon;
  final String? svgIcon;
  final String hint;
  final String actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final double? iconSize;
  final double? spacing;

  const SimpleInputRow({
    super.key,
    this.icon,
    this.svgIcon,
    required this.hint,
    required this.actionLabel,
    this.actionIcon,
    this.onActionTap,
    this.iconSize,
    this.spacing,
  }) : assert(
         icon != null || svgIcon != null,
         'Either icon or svgIcon must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (svgIcon != null)
          SvgPicture.asset(
            svgIcon!,
            colorFilter: const ColorFilter.mode(
              Color(0xFF8E8E93),
              BlendMode.srcIn,
            ),
            width: iconSize ?? 20.sp,
            height: iconSize ?? 20.sp,
          )
        else
          Icon(icon, color: Colors.grey[500], size: iconSize ?? 18.sp),
        SizedBox(width: spacing ?? (svgIcon != null ? 16.w : 13.w)),
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
