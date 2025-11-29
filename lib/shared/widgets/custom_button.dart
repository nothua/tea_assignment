import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? shadowColor;
  final double? borderRadius;
  final bool hasBorder;
  final Color? borderColor;
  final double? borderWidth;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.elevation,
    this.shadowColor,
    this.borderRadius,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.white,
            side: hasBorder 
                ? BorderSide(
                    color: borderColor ?? Colors.black,
                    width: borderWidth ?? 1.0,
                  )
                : BorderSide.none,
            elevation: elevation ?? 2,
            shadowColor: shadowColor ?? Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.outfit(
              fontSize: fontSize ?? 20.sp,
              fontWeight: fontWeight ?? FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shadowColor: shadowColor,
          elevation: elevation ?? 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
            side: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.black,
                    width: borderWidth ?? 1.0,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: fontSize ?? 20.sp,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
