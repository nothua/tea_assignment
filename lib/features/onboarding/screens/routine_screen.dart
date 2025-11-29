import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/onboarding/screens/summary_screen.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';
import 'package:tea_assignment/shared/widgets/time_range_picker.dart';
import 'package:tea_assignment/shared/widgets/custom_choice_chip.dart';
class RoutineScreen extends StatefulWidget {
  final bool isWakeUp;

  const RoutineScreen({super.key, required this.isWakeUp});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  // Wake-up times
  TimeOfDay _wakeUpStartTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _wakeUpEndTime = const TimeOfDay(hour: 8, minute: 0);
  
  // Bedtime times
  TimeOfDay _bedtimeStartTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _bedtimeEndTime = const TimeOfDay(hour: 23, minute: 0);

  final List<String> _selectedActivities = [];

  final List<String> _wakeUpActivities = [
    'Day Planning',
    'Breakfast',
    'Exercise',
    'Shower',
  ];
  final List<String> _bedtimeActivities = [
    'Self Reflection',
    'Stretching',
    'Check Social',
    'Read Book',
  ];

  @override
  Widget build(BuildContext context) {
    final isWakeUp = widget.isWakeUp;
    final activities = isWakeUp ? _wakeUpActivities : _bedtimeActivities;
    final title = isWakeUp ? 'Wake-up Routine' : 'Bedtime Routine';
    final subtitle = isWakeUp
        ? 'When do you usually wake-up?'
        : 'When do you usually sleep?';
    final question2 = isWakeUp
        ? 'How do you start your day?'
        : 'How do you unwind?';
    final text = isWakeUp
        ? "Pick the range that applies to most days."
        : "Time you prefer to begin a good night's rest.";
    final progress = isWakeUp ? 0.75 : 0.90;

    return OnboardingLayout(
      title: title,
      subtitle: subtitle,
      progress: progress,
      text: text,
      backgroundImage: isWakeUp
          ? 'assets/images/illustrations/wakeup_routine.png'
          : 'assets/images/illustrations/bedtime_routine.png',
      onContinue: () {
        if (isWakeUp) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RoutineScreen(isWakeUp: false),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SummaryScreen()),
          );
        }
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 300.h),
        child: Column(
          children: [
            TimeRangePicker(
              startTime: isWakeUp ? _wakeUpStartTime : _bedtimeStartTime,
              endTime: isWakeUp ? _wakeUpEndTime : _bedtimeEndTime,
              onStartTimeChanged: (time) {
                setState(() {
                  if (isWakeUp) {
                    _wakeUpStartTime = time;
                  } else {
                    _bedtimeStartTime = time;
                  }
                });
              },
              onEndTimeChanged: (time) {
                setState(() {
                  if (isWakeUp) {
                    _wakeUpEndTime = time;
                  } else {
                    _bedtimeEndTime = time;
                  }
                });
              },
            ),
            SizedBox(height: AppDimensions.spacing30),
            Text(
              question2,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimensions.spacing16),
            Wrap(
              spacing: AppDimensions.spacing10,
              runSpacing: AppDimensions.spacing10,
              alignment: WrapAlignment.center,
              children: [
                ...activities.map((activity) {
                  final isSelected = _selectedActivities.contains(activity);
                  return CustomChoiceChip(
                    label: activity,
                    isSelected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedActivities.add(activity);
                        } else {
                          _selectedActivities.remove(activity);
                        }
                      });
                    },
                    selectedColor: AppColors.sliderActive,
                    backgroundColor: AppColors.backgroundTransparent,
                    selectedLabelColor: AppColors.whiteColor,
                    unselectedLabelColor: AppColors.textBlack87,
                    selectedBorderColor: AppColors.sliderActive,
                    unselectedBorderColor: Colors.grey.shade300,
                  );
                }),
                ActionChip(
                  label: const Text('Add your own'),
                  avatar: Icon(Icons.edit, size: AppDimensions.iconSize16),
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.choiceChipRadius,
                    ),
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
