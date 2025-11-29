import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppDimensions.textFieldLabelFontSize,
            color: AppColors.textBlack87,
          ),
        ),
        SizedBox(height: AppDimensions.spacing8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textBlack),
            filled: true,
            fillColor: AppColors.backgroundWhite,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimensions.textFieldHorizontalPadding,
              vertical: AppDimensions.textFieldVerticalPadding,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.textFieldBorderRadius),
              borderSide: const BorderSide(color: AppColors.borderBlack),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.textFieldBorderRadius),
              borderSide: const BorderSide(color: AppColors.borderBlack),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.textFieldBorderRadius),
              borderSide: const BorderSide(color: AppColors.borderBlack),
            ),
            suffixIcon: isPassword
                ? const Icon(Icons.visibility_outlined, color: AppColors.iconBlack)
                : null,
          ),
        ),
      ],
    );
  }
}
