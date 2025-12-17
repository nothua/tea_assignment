import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/routines/widgets/routine_card.dart';
import 'package:tea_assignment/features/routines/widgets/routine_task_item.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';

class BedtimeRoutineScreen extends StatefulWidget {
  const BedtimeRoutineScreen({super.key});

  @override
  State<BedtimeRoutineScreen> createState() => _BedtimeRoutineScreenState();
}

class _BedtimeRoutineScreenState extends State<BedtimeRoutineScreen> {
  final List<Map<String, dynamic>> _bedtimeTasks = [
    {
      'title': 'Workout',
      'date': 'December 1, 2025',
      'time': '05:00AM',
      'duration': '1h 00m',
      'color': const Color(0xFFEF5350),
      'isDetailed': true,
    },
    {
      'title': 'Workout',
      'date': 'December 1, 2025',
      'time': '05:00AM',
      'duration': '1h 00m',
      'color': const Color(0xFFEF5350),
      'isDetailed': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Bedtime Routine',
      backgroundImage: 'assets/images/illustrations/bedtime_routine.png',
      showProgressBar: false,
      showButton: false,
      expandChild: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Bedtime Routine',
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            RoutineCard(
              title: 'Bedtime Routine',
              startTime: 'hh:mm AM',
              endTime: 'hh:mm',
              frequency: 'Daily',
              iconAsset: 'assets/images/icons/night.svg',
              iconColor: const Color(0xFF7E57C2),
              iconBackgroundColor: const Color(0xFFEDE7F6),
              onEdit: () {},
              showExpandIcon: true,
            ),

            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Your Routine Tasks',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    buildDefaultDragHandles: false,
                    itemCount: _bedtimeTasks.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = _bedtimeTasks.removeAt(oldIndex);
                        _bedtimeTasks.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (context, index) {
                      final task = _bedtimeTasks[index];
                      return ReorderableDelayedDragStartListener(
                        key: ValueKey(task['title'] + index.toString()),
                        index: index,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBEBFF),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: RoutineTaskItem(
                            title: task['title'],
                            date: task['date'],
                            time: task['time'],
                            duration: task['duration'],
                            color: task['color'],
                            isDetailed: task['isDetailed'],
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9B82FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        elevation: 0,
                      ),
                      child: Text(
                        'Add a Task',
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
