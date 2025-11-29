import 'package:flutter/material.dart';

import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final OutlinedBorder? shape;
  final Widget? trailing;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.selectedColor,
    this.backgroundColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.shape,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      color: isSelected
          ? (selectedLabelColor ?? Colors.white)
          : (unselectedLabelColor ?? AppColors.textBlack87),
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      fontSize: AppDimensions.fontSize14,
    );

    return ChoiceChip(
      label: trailing == null
          ? Text(label)
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: labelStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: AppDimensions.padding8),
                trailing!,
              ],
            ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: selectedColor ?? AppColors.choiceChipSelected,
      backgroundColor: backgroundColor ?? Colors.white,
      labelStyle: labelStyle,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.choiceChipRadius,
            ),
            side: BorderSide(
              color: isSelected
                  ? (selectedBorderColor ?? AppColors.choiceChipSelected)
                  : (unselectedBorderColor ?? Colors.grey.shade300),
              width: AppDimensions.choiceChipBorderWidth,
            ),
          ),
      showCheckmark: false,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.choiceChipHorizontalPadding,
        vertical: AppDimensions.choiceChipVerticalPadding,
      ),
    );
  }
}
