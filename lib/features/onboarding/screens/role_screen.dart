import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/auth/screens/create_account_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/productivity_screen.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final List<String> _selectedRoles = [];
  final List<String> _roles = [
    'Student', 'Employee', 'Freelancer',
    'Parent', 'Dreamer', 'Nomad',
    'Artist', 'Creator', 'Writer',
    'Influencer', 'Analyst', 'Networker',
    'Leader', 'Boss', 'Owner',
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
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: _roles.map((role) {
          final isSelected = _selectedRoles.contains(role);
          return ChoiceChip(
            label: Text(role),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedRoles.add(role);
                } else {
                  _selectedRoles.remove(role);
                }
              });
            },
            selectedColor: const Color(0xFFF3F0FF),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.choiceChipRadius),
              side: BorderSide(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
              ),
            ),
            showCheckmark: false,
          );
        }).toList(),
      ),
    );
  }
}
