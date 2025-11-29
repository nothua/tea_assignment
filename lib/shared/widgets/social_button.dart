import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;

  const SocialButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.socialButtonHeight,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(AppDimensions.socialButtonBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.iconBlack.withValues(alpha: AppDimensions.socialButtonShadowOpacity),
            blurRadius: AppDimensions.socialButtonBlurRadius,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor, size: AppDimensions.socialButtonIconSize),
        label: Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: AppDimensions.fontSize14,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack87,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.backgroundTransparent,
          foregroundColor: AppColors.textBlack87,
          shadowColor: AppColors.backgroundTransparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.socialButtonBorderRadius),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
