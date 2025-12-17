import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/routines/screens/bedtime_routine_screen.dart';
import 'package:tea_assignment/features/routines/screens/wake_up_routine_screen.dart';
import 'package:tea_assignment/features/routines/widgets/routine_card.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Routines',
      backgroundImage: 'assets/images/illustrations/bedtime_routine.png',
      showProgressBar: false,
      showButton: false,
      expandChild: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Default Routines'),
            SizedBox(height: 16.h),
            RoutineCard(
              title: 'Wake-Up Routine',
              startTime: 'hh:mm AM',
              endTime: 'hh:mm',
              frequency: 'Daily',
              iconAsset: 'assets/images/icons/sun.svg',
              iconColor: const Color(0xFFFFA726), // Orange
              iconBackgroundColor: const Color(0xFFFFF3E0), // Light Orange
              onEdit: () {},
              showExpandIcon: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WakeUpRoutineScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            RoutineCard(
              title: 'Bedtime Routine',
              startTime: 'hh:mm AM',
              endTime: 'hh:mm',
              frequency: 'Daily',
              iconAsset: 'assets/images/icons/night.svg',
              iconColor: const Color(0xFF7E57C2), // Deep Purple
              iconBackgroundColor: const Color(0xFFEDE7F6), // Light Purple
              onEdit: () {},
              showExpandIcon: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BedtimeRoutineScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
            _buildSectionTitle('Custom Routines'),
            SizedBox(height: 16.h),
            RoutineCard(
              title: 'Gym',
              startTime: 'hh:mm AM',
              endTime: 'hh:mm',
              frequency: 'S M T W T F S',
              iconAsset: 'assets/images/icons/repeat.svg',
              iconColor: const Color(0xFF42A5F5), // Blue
              iconBackgroundColor: const Color(0xFFE3F2FD), // Light Blue
              onEdit: () {},
              showExpandIcon: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Roboto Flex',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}
