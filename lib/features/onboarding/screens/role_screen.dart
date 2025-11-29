import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/onboarding/screens/productivity_screen.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';
import 'package:tea_assignment/shared/widgets/custom_choice_chip.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final List<String> _selectedRoles = [];
  final List<String> _roles = [
    'Student',
    'Employee',
    'Freelancer',
    'Parent',
    'Dreamer',
    'Nomad',
    'Artist',
    'Creator',
    'Writer',
    'Influencer',
    'Analyst',
    'Networker',
    'Leader',
    'Boss',
    'Owner',
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'About Yourself',
      subtitle: 'How do you describe yourself?',
      text: "Picking everything that fits you",
      progress: 0.30,
      backgroundImage: 'assets/images/illustrations/about_yourself_2.png',
      onContinue: () {
        if (_selectedRoles.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductivityScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select at least one role')),
          );
        }
      },
      child: Wrap(
        spacing: AppDimensions.spacing10,
        runSpacing: AppDimensions.spacing10,
        alignment: WrapAlignment.center,
        children: _roles.map((role) {
          final isSelected = _selectedRoles.contains(role);
          return CustomChoiceChip(
            label: role,
            isSelected: isSelected,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedRoles.add(role);
                } else {
                  _selectedRoles.remove(role);
                }
              });
            },
            selectedColor: AppColors.sliderActive,
            backgroundColor: AppColors.backgroundTransparent,
            selectedLabelColor: AppColors.whiteColor,
            unselectedLabelColor: AppColors.textBlack87,
            selectedBorderColor: AppColors.sliderActive,
            unselectedBorderColor: Colors.grey.shade300,
            trailing: Icon(
              isSelected ? Icons.remove : Icons.add,
              size: AppDimensions.iconSize16,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : AppColors.textBlack87,
            ),
          );
        }).toList(),
      ),
    );
  }
}
