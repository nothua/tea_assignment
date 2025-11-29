import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/onboarding/screens/routine_screen.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';

class EnergyScreen extends StatefulWidget {
  const EnergyScreen({super.key});

  @override
  State<EnergyScreen> createState() => _EnergyScreenState();
}

class _EnergyScreenState extends State<EnergyScreen> {
  double _sleepHours = 7;
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
      onContinue: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RoutineScreen(isWakeUp: true)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Do you struggle to get out of bed?', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: ['Yes', 'Sometimes', 'No'].map((option) {
              final isSelected = _struggleToGetOutOfBed == option;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _struggleToGetOutOfBed = option;
                    });
                  },
                  selectedColor: const Color(0xFFF3F0FF),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.choiceChipRadius),
                    side: BorderSide(
                      color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          
          const Text('How many hours of sleep do you typically get?', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Slider(
            value: _sleepHours,
            min: 3,
            max: 12,
            divisions: 9,
            label: '${_sleepHours.round()}h',
            onChanged: (value) {
              setState(() {
                _sleepHours = value;
              });
            },
            activeColor: Theme.of(context).primaryColor,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('3h', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('12h', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 24),
          
          const Text('How energized are you throughout the day?', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Slider(
            value: _energyLevel,
            onChanged: (value) {
              setState(() {
                _energyLevel = value;
              });
            },
            activeColor: Theme.of(context).primaryColor,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Low', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('Neutral', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('Energized', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
