import 'package:flutter/material.dart';

import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';
import 'package:tea_assignment/features/onboarding/screens/role_screen.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String? _selectedAge;
  final List<String> _ageRanges = [
    '15-25 years old',
    '26-35 years old',
    '36-45 years old',
    'Above 46 years old',
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'About Yourself',
      subtitle: 'Tell us your age',
      text: "We tailor your experience based on this",
      progress: 0.15,
      backgroundImage: 'assets/images/illustrations/about_yourself_1.png',
      onContinue: () {
        if (_selectedAge != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoleScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select your age')),
          );
        }
      },
      child: Column(
        children: [
          SizedBox(height: AppDimensions.spacing24),
          ..._ageRanges.map((age) {
            final isSelected = _selectedAge == age;
            return Padding(
              padding: EdgeInsets.only(bottom: AppDimensions.spacing12),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedAge = age;
                  });
                },
                borderRadius: BorderRadius.circular(
                  AppDimensions.choiceChipRadius,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.padding16,
                    horizontal: AppDimensions.padding24,
                  ),
                  decoration: BoxDecoration(
                    color: !isSelected
                        ? AppColors.choiceChipBackground
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.choiceChipRadius,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300,
                      width: isSelected
                          ? AppDimensions.borderWidth1_5
                          : AppDimensions.borderWidth1,
                    ),
                  ),
                  child: Text(
                    age,
                    style: TextStyle(
                      fontSize: AppDimensions.fontSize16,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
