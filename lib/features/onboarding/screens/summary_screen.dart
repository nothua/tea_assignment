import 'package:flutter/material.dart';

import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/dashboard/screens/first_task_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/success_screen.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Summary',
      subtitle: 'Your Personal Profile Summary',
      text: "Based on your inputs, here is a snapshot of your habits",
      progress: 1.0,
      backgroundImage: 'assets/images/illustrations/summary.png',
      onContinue: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(
              nextScreen: const FirstTaskScreen(),
              title: 'Welcome to TEA',
              subtitle: 'A Better You Is Closer Than You Think',
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            icon: Icons.school,
            iconColor: AppColors.textSecondary,
            title: 'Life Purpose',
            content: Text(
              'Student',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: AppDimensions.fontSize15,
                color: AppColors.textBody,
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spacing24),
          _buildSection(
            icon: Icons.bed_rounded,
            iconColor: AppColors.textGrey,
            title: 'Sleep Patterns',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBulletPoint(
                  'You typically sleep between 10:00 PM and 6:00 AM',
                ),
                _buildBulletPoint(
                  'You average around 8 hours of rest each night',
                ),
                _buildBulletPoint(
                  'You usually wake up between 10:00 PM and 6:00 AM',
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimensions.spacing24),
          _buildSection(
            icon: Icons.star_rounded,
            iconColor: AppColors.iconYellow,
            title: 'Interests & Decisions',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBulletPoint(
                  'You align your habits with your productivity cycles',
                ),
                _buildBulletPoint(
                  'You\'re committed to improving your 30-day routine',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppDimensions.padding2),
          child: Icon(icon, size: AppDimensions.iconSize22, color: iconColor),
        ),
        SizedBox(width: AppDimensions.padding14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                  fontSize: AppDimensions.fontSize16,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppDimensions.spacing8),
              content,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.spacing8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: AppDimensions.fontSize15,
              color: AppColors.textBody,
              height: 1.4,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: AppDimensions.fontSize15,
                color: AppColors.textBody,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
