import 'package:flutter/material.dart';
import 'package:tea_assignment/features/dashboard/screens/first_task_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/success_screen.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});
    static const Color kBodyColor = Color(0xFF555555);

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
                  iconColor: const Color(0xFF2C2C2C), 
                  title: 'Life Purpose',
                  content: const Text(
                    'Student',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 15,
                      color: kBodyColor,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),

                _buildSection(
                  icon: Icons.bed_rounded,
                  iconColor: const Color(0xFF6B7280),
                  title: 'Sleep Patterns',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBulletPoint('You typically sleep between 10:00 PM and 6:00 AM'),
                      _buildBulletPoint('You average around 8 hours of rest each night'),
                      _buildBulletPoint('You usually wake up between 10:00 PM and 6:00 AM'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                _buildSection(
                  icon: Icons.star_rounded,
                  iconColor: const Color(0xFFFFB800), 
                  title: 'Interests & Decisions',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBulletPoint('You align your habits with your productivity cycles'),
                      _buildBulletPoint('You\'re committed to improving your 30-day routine'),
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
        // Icon wrapper to align with text
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Icon(icon, size: 22, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 8),
              content,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 15,
              color: Color(0xFF555555),
              height: 1.4,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'DMSans',
                fontSize: 15,
                color: Color(0xFF555555),
                height: 1.4, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
