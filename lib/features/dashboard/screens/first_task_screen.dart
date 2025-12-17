import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';
import 'package:tea_assignment/shared/widgets/custom_choice_chip.dart';

class FirstTaskScreen extends StatefulWidget {
  const FirstTaskScreen({super.key});

  @override
  State<FirstTaskScreen> createState() => _FirstTaskScreenState();
}

class _FirstTaskScreenState extends State<FirstTaskScreen> {
  String? _selectedTask;
  String _selectedDay = 'Today';

  final List<String> _tasks = [
    'Exercise',
    'Meditate',
    'Plan Meals',
    'Read',
    'Organize Workspace',
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Clarity Starts Here',
      subtitle: 'Start Your First Action',
      text: "Choose One Thing you'd like to complete today",
      showProgressBar: false,
      imageSpaceHeight: 120,
      backgroundImage: 'assets/images/illustrations/clarity_starts_here.png',
      onContinue: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Setup Complete!')));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What\'s one task you want to complete today?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _tasks.map((task) {
                final isSelected = _selectedTask == task;
                return CustomChoiceChip(
                  label: task,
                  isSelected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedTask = selected ? task : null;
                    });
                  },
                  selectedColor: AppColors.sliderActive,
                  backgroundColor: AppColors.backgroundTransparent,
                  selectedLabelColor: AppColors.whiteColor,
                  unselectedLabelColor: AppColors.textBlack87,
                  selectedBorderColor: AppColors.sliderActive,
                  unselectedBorderColor: Colors.grey.shade300,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            const Text(
              'When would you like to do this?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildDayButton('Today')),
                const SizedBox(width: 16),
                Expanded(child: _buildDayButton('Tomorrow')),
              ],
            ),
            const SizedBox(height: 24),

            _buildTimeRow('Select Start Time', '00:00 AM'),
            const SizedBox(height: 16),
            _buildTimeRow('Estimated Duration', '00:00'),
          ],
        ),
      ),
    );
  }

  Widget _buildDayButton(String day) {
    final isSelected = _selectedDay == day;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDay = day;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3F0FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
