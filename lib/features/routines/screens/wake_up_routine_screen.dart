import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/routines/widgets/routine_task_item.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';
import 'package:tea_assignment/features/routines/screens/edit_routine_screen.dart'; // Import Edit Screen
import 'package:tea_assignment/shared/widgets/tag_chip.dart';

import 'package:tea_assignment/shared/widgets/circle_icon_button.dart';

class WakeUpRoutineScreen extends StatefulWidget {
  const WakeUpRoutineScreen({super.key});

  @override
  State<WakeUpRoutineScreen> createState() => _WakeUpRoutineScreenState();
}

class _WakeUpRoutineScreenState extends State<WakeUpRoutineScreen> {
  String _notificationTime = "15 minutes before";
  bool _isAlarmEnabled = false;
  bool _isNotificationEnabled = true;

  final TextEditingController _notesController = TextEditingController();
  final List<String> _tags = [];

  // Dummy data for reorderable list
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Brush',
      'time': '07:35 AM',
      'duration': 'hh:mm',
      'color': const Color(0xFFEF5350),
      'isDetailed': false,
      'isChecked': true,
    },
    {
      'title': 'Skincare',
      'time': '07:40 AM',
      'duration': 'hh:mm',
      'color': const Color(0xFFEF5350),
      'isDetailed': false,
      'isChecked': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Wake-Up Routine',
      backgroundImage: 'assets/images/illustrations/wakeup_routine.png',
      showProgressBar: false,
      showButton: false,
      expandChild: true,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: SizedBox(
          width: 56.w,
          height: 56.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditRoutineScreen(),
                ),
              );
            },
            backgroundColor: const Color(0xFF7E57C2), // Purple color
            shape: const CircleBorder(),
            elevation: 4,
            child: Icon(Icons.edit_outlined, size: 24.sp, color: Colors.white),
          ),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20.w,
          24.h,
          20.w,
          80.h,
        ), // Extra padding for FAB
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            SizedBox(height: 16.h),
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
                      _isAlarmEnabled
                          ? 'Audible Alarm On'
                          : 'Audible Alarm Off',
                      style: TextStyle(
                        fontFamily: 'Roboto Flex', // Changed font
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400, // Regular weight
                        color: const Color(0xFF333333),
                      ),
                    ),
                  ),
                  CircleIconButton(
                    icon: Icons.alarm, // Fallback
                    svgIcon: 'assets/images/icons/alarm.svg',
                    size: 28.w,
                    iconSize: 16.sp,
                    color: _isAlarmEnabled
                        ? const Color(0xFFF3F0FF)
                        : Colors.transparent,
                    iconColor: _isAlarmEnabled
                        ? const Color(0xFF333333)
                        : const Color(0xFF8E8E93),
                    boxShadow: [],
                    onTap: () {
                      setState(() {
                        _isAlarmEnabled = !_isAlarmEnabled;
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
                      'assets/images/icons/notification_alarm.svg', // Swapped icon
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
                            fontFamily: 'Roboto Flex', // Changed font
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400, // Regular weight
                            color: const Color(0xFF12112B),
                          ),
                        ),
                        if (_isNotificationEnabled) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 16.sp,
                            color: const Color(0xFF12112B),
                          ),
                        ],
                      ],
                    ),
                  ),
                  CircleIconButton(
                    svgIcon: _isNotificationEnabled
                        ? 'assets/images/icons/notification.svg' // Swapped icon back
                        : 'assets/images/icons/no_notification_alarm.svg',
                    size: 28.w,
                    iconSize: 16.sp,
                    color: const Color(0xFFF3F0FF),
                    iconColor: _isNotificationEnabled
                        ? const Color(0xFF333333)
                        : const Color(0xFF8E8E93),
                    boxShadow: [],
                    onTap: () {
                      setState(() {
                        _isNotificationEnabled = !_isNotificationEnabled;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 36.w),
              child: Row(
                children: [
                  Container(
                    width: 24.w,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/icons/stickynote.svg',
                      width: 15.sp,
                      height: 15.sp,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF8E8E93),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 24.w),
                      alignment: Alignment.centerLeft,
                      child: _notesController.text.isEmpty
                          ? Text(
                              'No notes',
                              style: TextStyle(
                                fontFamily: 'Roboto Flex',
                                fontSize: 14.sp,
                                color: AppColors.textGrey,
                              ),
                            )
                          : Text(
                              _notesController.text,
                              style: TextStyle(
                                fontFamily: 'Roboto Flex',
                                fontSize: 14.sp,
                                color: const Color(0xFF12112B),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),
            // Tags Row
            Padding(
              padding: EdgeInsets.only(left: 36.w),
              child: Row(
                children: [
                  Container(
                    width: 24.w,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/icons/tag.svg",
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF8E8E93),
                        BlendMode.srcIn,
                      ),
                      width: 15.sp,
                      height: 15.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 24.w),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            if (_tags.isEmpty)
                              Text(
                                "No tags",
                                style: TextStyle(
                                  fontFamily: 'Roboto Flex',
                                  fontSize: 14.sp,
                                  color: AppColors.textGrey,
                                ),
                              )
                            else
                              ..._tags.map((tag) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: TagChip(label: tag),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Tasks List
            Text(
              'Tasks Within Routine (${_tasks.length})',
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),

            ReorderableListView.builder(
              padding: EdgeInsets.symmetric(vertical: 0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              proxyDecorator: (child, index, animation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    final double animValue = Curves.easeInOut.transform(
                      animation.value,
                    );
                    final double elevation = lerpDouble(0, 6, animValue)!;
                    return Material(
                      elevation: elevation,
                      color: Colors.transparent,
                      shadowColor: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                      child: child,
                    );
                  },
                  child: child,
                );
              },
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
                // Use a Key that is unique. 'task['title']' might not be unique enough but okay for now.
                return Padding(
                  key: ValueKey(task['title'] + index.toString()),
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: RoutineTaskItem(
                    index: index, // Pass index for drag handle
                    title: task['title'],
                    time: task['time'],
                    duration: task['duration'],
                    color: task['color'],
                    isDetailed: task['isDetailed'],
                    isChecked: task['isChecked'] ?? false,
                    showDivider: false,
                    onChanged: (value) {
                      setState(() {
                        task['isChecked'] = value;
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.h),
          child: Container(
            width: 35.w,
            height: 35.w,
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEFA7), // Light yellow background
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset('assets/images/icons/sun.svg'),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                'Wake-Up Routine',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF333333),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Group: Time and Duration
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/clock.svg',
                        width: 14.sp,
                        height: 14.sp,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF333333),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '07:00 AM',
                        style: TextStyle(
                          fontFamily: 'Roboto Flex', // Regular font
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400, // Not bold
                          color: const Color(0xFF6B6B6B),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SvgPicture.asset(
                        'assets/images/icons/alarm.svg',
                        width: 14.sp,
                        height: 14.sp,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF333333),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'hh:mm',
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400, // Not bold
                          color: const Color(0xFF6B6B6B),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Right Group: Daily
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/repeat.svg',
                        width: 14.sp,
                        height: 14.sp,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF333333),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Daily',
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400, // Not bold
                          color: const Color(0xFF6B6B6B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
