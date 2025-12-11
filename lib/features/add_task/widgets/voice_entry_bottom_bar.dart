import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';

class VoiceEntryBottomBar extends StatelessWidget {
  final VoidCallback? onClose;
  final VoidCallback? onCheck;
  final bool showVoiceButton;
  final VoidCallback? onVoiceEntry;

  const VoiceEntryBottomBar({
    super.key,
    this.onClose,
    this.onCheck,
    this.onVoiceEntry,
    this.showVoiceButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleButton(icon: Icons.close, onTap: onClose),
          if (showVoiceButton)
            GestureDetector(
              onTap: onVoiceEntry,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEA),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF3B30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mic_none,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Voice Entry",
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF12112B),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SizedBox(width: 40.w),
          _buildCircleButton(icon: Icons.check, onTap: onCheck),
        ],
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColors.greyF7,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.grey[400], size: 24.sp),
      ),
    );
  }
}
