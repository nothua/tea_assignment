import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';

import 'package:tea_assignment/shared/widgets/selectable_chip.dart';
import 'package:tea_assignment/shared/widgets/icon_text_button.dart';

import 'package:flutter_svg/flutter_svg.dart';

class DurationSelectionRow extends StatelessWidget {
  final String selectedDuration;
  final List<String> options;
  final Function(String) onDurationSelected;
  final VoidCallback? onSetCustom;

  const DurationSelectionRow({
    super.key,
    required this.selectedDuration,
    required this.options,
    required this.onDurationSelected,
    this.onSetCustom,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/icons/clock.svg",
          colorFilter: const ColorFilter.mode(
            Color(0xFF8E8E93),
            BlendMode.srcIn,
          ),
          width: 18.sp,
          height: 18.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          "*",
          style: TextStyle(color: AppColors.iconRed, fontSize: 12.sp),
        ),
        SizedBox(width: 4.w),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Row(
              children: options.map((duration) {
                final isSelected = duration == selectedDuration;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: SelectableChip(
                    label: duration,
                    isSelected: isSelected,
                    onTap: () => onDurationSelected(duration),
                    selectedColor: const Color(0xFFE0E0F6),
                    selectedTextColor: const Color(0xFF5F5FBC),
                    unselectedColor: AppColors.greyF7,
                    unselectedTextColor: const Color(0xFFA0A0C0),
                    showCheckmark: true,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto Flex',
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        SizedBox(width: 8.w),
        IconTextButton(
          svgIcon: "assets/images/icons/system_icons.svg",
          label: "Set",
          onTap: onSetCustom,
          color: Colors.blue[600],
          iconSize: 20.sp,
          fontSize: 12.sp,
        ),
      ],
    );
  }
}
