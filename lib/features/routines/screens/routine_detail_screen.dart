import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';
import 'package:tea_assignment/features/routines/widgets/routine_card.dart';
import 'package:tea_assignment/features/routines/widgets/routine_task_item.dart';
import 'package:tea_assignment/features/routines/widgets/suggested_task_chip.dart';
import 'package:tea_assignment/shared/widgets/custom_switch.dart';

class RoutineDetailScreen extends StatefulWidget {
  final String title;
  final bool isWakeUp;

  const RoutineDetailScreen({
    super.key,
    required this.title,
    required this.isWakeUp,
  });

  @override
  State<RoutineDetailScreen> createState() => _RoutineDetailScreenState();
}

class _RoutineDetailScreenState extends State<RoutineDetailScreen> {
  bool _isAlarmEnabled = true;
  bool _isNotificationEnabled = true;
  String _notificationTime = "15 minutes before";

  // Dummy data for reorderable list
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Brush',
      'duration': 'hh:mm',
      'color': const Color(0xFFEF5350),
      'isDetailed': false,
    },
    {
      'title': 'Skincare',
      'duration': 'hh:mm',
      'color': const Color(0xFFEF5350),
      'isDetailed': false,
    },
  ];

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
      title: widget.isWakeUp ? 'Wake-Up Routine' : 'Bedtime Routine',
      backgroundImage: widget.isWakeUp
          ? 'assets/images/illustrations/wakeup_routine.png'
          : 'assets/images/illustrations/bedtime_routine.png',
      showProgressBar: false,
      showButton: false,
      expandChild: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isWakeUp) ...[
              // Wake-Up Routine Layout
              _buildWakeUpHeader(),
              SizedBox(height: 24.h),
              // Ring Alarm Row
              Padding(
                padding: EdgeInsets.only(left: 36.w),
                child: Row(
                  children: [
                    Container(
                      width: 24.w,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/icons/alarm.svg',
                        width: 16.sp,
                        height: 16.sp,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF8E8E93),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Alarm',
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    CustomSwitch(
                      value: _isAlarmEnabled,
                      onChanged: (val) {
                        setState(() {
                          _isAlarmEnabled = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Notification Row
              Padding(
                padding: EdgeInsets.only(left: 36.w),
                child: Row(
                  children: [
                    Container(
                      width: 24.w,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/icons/notification.svg',
                        width: 16.sp,
                        height: 16.sp,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF8E8E93),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isNotificationEnabled
                                ? _notificationTime
                                : "Notification Off",
                            style: TextStyle(
                              fontFamily: 'Roboto Flex',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (_isNotificationEnabled) ...[
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 20.sp,
                              color: AppColors.textPrimary,
                            ),
                          ],
                        ],
                      ),
                    ),
                    CustomSwitch(
                      value: _isNotificationEnabled,
                      onChanged: (val) {
                        setState(() {
                          _isNotificationEnabled = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(
                    Icons.note_add_outlined,
                    color: AppColors.textGrey,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Add notes',
                    style: TextStyle(
                      fontFamily: 'Roboto Flex',
                      fontSize: 14.sp,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Bedtime Routine Layout
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
            ],

            SizedBox(height: 24.h),

            // Tasks List
            Text(
              widget.isWakeUp
                  ? 'Tasks Within Routine (${_tasks.length})'
                  : 'Your Routine Tasks',
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),

            if (widget.isWakeUp) ...[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    buildDefaultDragHandles: false,
                    itemCount: _tasks.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = _tasks.removeAt(oldIndex);
                        _tasks.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ReorderableDelayedDragStartListener(
                        key: ValueKey(task['title'] + index.toString()),
                        index: index,
                        child: Container(
                          child: RoutineTaskItem(
                            title: task['title'],
                            duration: task['duration'],
                            color: task['color'],
                            isDetailed: task['isDetailed'],
                            showDivider: index != _tasks.length - 1, // Logic
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: ReorderableListView.builder(
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
                          child: RoutineTaskItem(
                            title: task['title'],
                            date: task['date'],
                            time: task['time'],
                            duration: task['duration'],
                            color: task['color'],
                            isDetailed: task['isDetailed'],
                            showDivider: index != _bedtimeTasks.length - 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],

            if (!widget.isWakeUp) ...[
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B82FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
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

            SizedBox(height: 24.h),

            // Suggested Tasks (Only for WakeUp)
            if (widget.isWakeUp) ...[
              Text(
                'Suggested Tasks',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              Center(
                child: Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  alignment: WrapAlignment.center,
                  children: [
                    SuggestedTaskChip(label: 'Day Planning', isSelected: true),
                    SuggestedTaskChip(label: 'Breakfast'),
                    SuggestedTaskChip(label: 'Exercise'),
                    SuggestedTaskChip(label: 'Shower'),
                    SuggestedTaskChip(label: 'Add your own', isAddButton: true),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWakeUpHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cached, size: 24.sp, color: AppColors.textPrimary),
                SizedBox(width: 12.w),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.access_time, size: 14.sp, color: AppColors.textGrey),
                SizedBox(width: 4.w),
                Text(
                  'hh:mm AM',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.access_time, size: 14.sp, color: AppColors.textGrey),
                SizedBox(width: 4.w),
                Text(
                  'hh:mm',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.repeat, size: 14.sp, color: AppColors.textGrey),
                SizedBox(width: 4.w),
                Text(
                  'Daily',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.event_repeat,
                  size: 14.sp,
                  color: AppColors.textGrey,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Never Ends',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.all_inclusive,
                  size: 14.sp,
                  color: AppColors.textGrey,
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F0FF),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.edit, size: 18.sp, color: AppColors.primaryPurple),
        ),
      ],
    );
  }
}
