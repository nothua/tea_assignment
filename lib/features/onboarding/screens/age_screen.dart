import 'package:flutter/material.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';

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
      progress: 0.15,
      backgroundImage: 'assets/images/illustrations/about_yourself_1.png',
      onContinue: () {
        if (_selectedAge != null) {
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select your age')),
          );
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 24),
          ..._ageRanges.map((age) {
          final isSelected = _selectedAge == age;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedAge = age;
                });
              },
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF3F0FF) : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  age,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
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
