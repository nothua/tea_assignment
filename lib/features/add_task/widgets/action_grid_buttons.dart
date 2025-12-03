import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class ActionGridButtons extends StatelessWidget {
  final VoidCallback? onLocationTap;
  final VoidCallback? onCompaniesTap;
  final VoidCallback? onContactsTap;
  final VoidCallback? onAttachmentsTap;

  const ActionGridButtons({
    super.key,
    this.onLocationTap,
    this.onCompaniesTap,
    this.onContactsTap,
    this.onAttachmentsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _bottomBtn(Icons.location_on_outlined, "Location", isSelected: true, onTap: onLocationTap),
        SizedBox(width: 8.w),
        _bottomBtn(Icons.domain, "Companies", isSelected: true, onTap: onCompaniesTap),
        SizedBox(width: 8.w),
        _bottomBtn(Icons.person_outline, "Contacts", isSelected: false, onTap: onContactsTap),
        SizedBox(width: 8.w),
        _bottomBtn(Icons.attach_file, "Attachments", isSelected: false, isLongText: true, onTap: onAttachmentsTap),
      ],
    );
  }

  Widget _bottomBtn(IconData icon, String label, {required bool isSelected, bool isLongText = false, VoidCallback? onTap}) {
    final bgColor = isSelected ? const Color(0xFFE0E0F6) : const Color(0xFFF7F7F8);
    final iconColor = isSelected ? const Color(0xFF5F5FBC) : const Color(0xFF8A8AB5);
    final textColor = isSelected ? const Color(0xFF5F5FBC) : const Color(0xFF8A8AB5);

    return Expanded(
      flex: isLongText ? 5 : 4,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 75.h,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: iconColor, size: 22.sp),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        label,
                        style: TextStyle(color: textColor, fontSize: 10.sp, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: isSelected 
                  ? Icon(Icons.check, size: 12.sp, color: textColor)
                  : Icon(Icons.add, size: 12.sp, color: textColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
