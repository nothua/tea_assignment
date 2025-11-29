import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/onboarding/screens/summary_screen.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';

class RoutineScreen extends StatefulWidget {
  final bool isWakeUp;

  const RoutineScreen({super.key, required this.isWakeUp});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 0);
  final List<String> _selectedActivities = [];

  final List<String> _wakeUpActivities = ['Day Planning', 'Breakfast', 'Exercise', 'Shower'];
  final List<String> _bedtimeActivities = ['Self Reflection', 'Stretching', 'Check Social', 'Read Book'];

  @override
  Widget build(BuildContext context) {
    final isWakeUp = widget.isWakeUp;
    final activities = isWakeUp ? _wakeUpActivities : _bedtimeActivities;
    final title = isWakeUp ? 'Wake-up Routine' : 'Bedtime Routine';
    final subtitle = isWakeUp ? 'When do you usually wake-up?' : 'When do you usually sleep?';
    final question2 = isWakeUp ? 'How do you start your day?' : 'How do you unwind?';
    final text = isWakeUp ? "Pick the range that applies to most days." : "Time you prefer to begin a good night's rest.";
    final progress = isWakeUp ? 0.75 : 0.90;

    return OnboardingLayout(
      title: title,
      subtitle: subtitle,
      progress: progress,
      text: text,
      backgroundImage: isWakeUp 
          ? 'assets/images/illustrations/wakeup_routine.png' // Morning
          : 'assets/images/illustrations/bedtime_routine.png', // Night
      onContinue: () {
        if (isWakeUp) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoutineScreen(isWakeUp: false)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SummaryScreen()),
          );
        }
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 300),
        child: Column(
          children: [
          // Time Picker Simulation
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _time.format(context),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.access_time),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          Text(question2, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ...activities.map((activity) {
                final isSelected = _selectedActivities.contains(activity);
                return ChoiceChip(
                  label: Text(activity),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedActivities.add(activity);
                      } else {
                        _selectedActivities.remove(activity);
                      }
                    });
                  },
                  selectedColor: const Color(0xFF8E7CFF), // Primary color for selected
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.choiceChipRadius),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  showCheckmark: false,
                );
              }),
              ActionChip(
                label: const Text('Add your own'),
                avatar: const Icon(Icons.edit, size: 16),
                onPressed: () {},
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.choiceChipRadius),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
