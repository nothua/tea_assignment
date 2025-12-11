import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/add_emotion/screens/add_emotion_screen.dart';
import 'package:tea_assignment/features/add_task/screens/add_task_screen.dart';
import 'package:tea_assignment/features/add_thoughts/screens/add_thoughts_screen.dart';

class AddMenuBottomSheet extends StatelessWidget {
  const AddMenuBottomSheet({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Close the bottom sheet
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "What would you like to add?",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.titleTextColor,
            ),
          ),
          SizedBox(height: 24.h),
          _buildOption(
            context,
            icon: Icons.mood,
            label: "Add Emotion",
            color: Colors.orange,
            onTap: () => _navigateTo(context, const AddEmotionScreen()),
          ),
          SizedBox(height: 16.h),
          _buildOption(
            context,
            icon: Icons.lightbulb_outline,
            label: "Add Thoughts",
            color: Colors.blue,
            onTap: () => _navigateTo(context, const AddThoughtsScreen()),
          ),
          SizedBox(height: 16.h),
          _buildOption(
            context,
            icon: Icons.check_circle_outline,
            label: "Add New Task",
            color: Colors.green,
            onTap: () => _navigateTo(context, const TaskCreationScreen()),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textBody,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
