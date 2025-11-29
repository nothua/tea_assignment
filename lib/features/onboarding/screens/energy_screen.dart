import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/onboarding/screens/routine_screen.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';
import 'package:tea_assignment/shared/widgets/custom_choice_chip.dart';
import 'package:tea_assignment/shared/widgets/slider/custom_slider.dart';

class EnergyScreen extends StatefulWidget {
  const EnergyScreen({super.key});

  @override
  State<EnergyScreen> createState() => _EnergyScreenState();
}

class _EnergyScreenState extends State<EnergyScreen> {
  double _sleepValue = 2;
  double _energyLevel = 0.5;
  String? _struggleToGetOutOfBed;

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Energy & Focus',
      subtitle: 'Let\'s understand your energy levels',
      text: "We use this to personalize your daily rhythm.",
      progress: 0.60,
      backgroundImage: 'assets/images/illustrations/energy_focus.png',
      buttonText: "Start Here",
      onContinue: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RoutineScreen(isWakeUp: true),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do you struggle to get out of bed?',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.fontSize16,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacing16),
          Row(
            children: ['Yes', 'Sometimes', 'No'].map((option) {
              final isSelected = _struggleToGetOutOfBed == option;
              return Padding(
                padding: EdgeInsets.only(right: AppDimensions.padding12),
                child: CustomChoiceChip(
                  label: option,
                  isSelected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _struggleToGetOutOfBed = option;
                    });
                  },
                  selectedColor: AppColors.sliderActive,
                  backgroundColor: AppColors.backgroundTransparent,
                  selectedLabelColor: AppColors.whiteColor,
                  unselectedLabelColor: AppColors.textBlack87,
                  selectedBorderColor: AppColors.sliderActive,
                  unselectedBorderColor: Colors.grey.shade300,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.sliderActive
                          : Colors.grey.shade300,
                      width: AppDimensions.borderWidth1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: AppDimensions.spacing32),
          Text(
            'How many hours of sleep do you typically get?',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.fontSize16,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacing12),
          CustomSlider(
            value: _sleepValue,
            min: 0,
            max: 4,
            divisions: 4,
            onChanged: (val) => setState(() => _sleepValue = val),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.padding10,
              vertical: AppDimensions.padding8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1h',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.fontSize12,
                  ),
                ),
                Text(
                  '3h',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.fontSize12,
                  ),
                ),
                Text(
                  '6h',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.fontSize12,
                  ),
                ),
                Text(
                  '9h',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.fontSize12,
                  ),
                ),
                Text(
                  'More\nthan 12h',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.fontSize12,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimensions.spacing24),
          Text(
            'How energized are you throughout the day?',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.fontSize16,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacing12),
          CustomSlider(
            value: _energyLevel,
            min: 0.0,
            max: 1.0,
            divisions: 2,
            hideEdgeTicks: true,
            onChanged: (val) => setState(() => _energyLevel = val),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.padding10,
              vertical: AppDimensions.padding8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Low',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.fontSize12,
                  ),
                ),
                Text(
                  'Neutral',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.fontSize12,
                  ),
                ),
                Text(
                  'Energized',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: AppDimensions.fontSize12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
