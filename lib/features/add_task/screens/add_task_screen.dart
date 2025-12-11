import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/add_task/widgets/notification_settings_row.dart';
import 'package:tea_assignment/features/add_task/widgets/tags_input_row.dart';
import 'package:tea_assignment/shared/widgets/selectable_chip.dart';
import 'package:intl/intl.dart';

import 'package:tea_assignment/features/add_task/widgets/calendar_sync_dialog.dart';
import 'package:tea_assignment/features/add_task/widgets/date_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/duration_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/enjoyment_purpose_sliders.dart';
import 'package:tea_assignment/features/add_task/widgets/header_section.dart';
import 'package:tea_assignment/features/add_task/widgets/voice_entry_bottom_bar.dart';

import 'package:tea_assignment/shared/widgets/app_header.dart';

class TaskCreationScreen extends StatelessWidget {
  const TaskCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyF2,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: AppHeader(
                title: "Add new Task",
                trailing: [
                  IconButton(
                    icon: Image.asset(
                      "assets/images/icons/Question Circle.png",
                      width: 24.w,
                      height: 24.w,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/icons/element-plus.png",
                      width: 24.w,
                      height: 24.w,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Expanded(child: TaskCreationSheet()),
            VoiceEntryBottomBar(
              onClose: () => Navigator.pop(context),
              onCheck: () {
                // Handle check action
              },
              onVoiceEntry: () {
                // Handle voice entry action
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCreationSheet extends StatefulWidget {
  const TaskCreationSheet({super.key});

  @override
  State<TaskCreationSheet> createState() => _TaskCreationSheetState();
}

class _TaskCreationSheetState extends State<TaskCreationSheet> {
  final List<String> _tags = ["Tag_1", "Tag_1", "Tag_1"];
  DateTime _selectedDate = DateTime(2025, 10, 15);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  bool _isNotificationEnabled = true;

  void _addTag() {
    showDialog(
      context: context,
      builder: (context) {
        String newTag = "";
        return AlertDialog(
          title: const Text("Add Tag"),
          content: TextField(
            autofocus: true,
            onChanged: (value) => newTag = value,
            decoration: const InputDecoration(hintText: "Enter tag name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (newTag.isNotEmpty) {
                  setState(() {
                    _tags.add(newTag);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String get _formattedDate {
    // Simple formatting for demo
    return DateFormat('MMMM d, yyyy').format(_selectedDate);
  }

  String get _formattedTime {
    return _selectedTime.format(context);
  }

  void _showCalendarSyncDialog() {
    showDialog(
      context: context,
      builder: (context) => const CalendarSyncDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 10.h),
                    child: const HeaderSection(),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              SelectableChip(
                                label: "Early Morning",
                                isSelected: false,
                                onTap: () {},
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFFB4B3EC),
                              ),
                              SizedBox(width: 8.w),
                              SelectableChip(
                                label: "Morning",
                                isSelected: false,
                                onTap: () {},
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFFB4B3EC),
                              ),
                              SizedBox(width: 8.w),
                              SelectableChip(
                                label: "Afternoon",
                                isSelected: false,
                                onTap: () {},
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFFB4B3EC),
                              ),
                              SizedBox(width: 8.w),
                              SelectableChip(
                                label: "Evening",
                                isSelected: false,
                                onTap: () {},
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFFB4B3EC),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        DateSelectionRow(
                          date: _formattedDate,
                          time: _formattedTime,
                          onDateTap: _pickDate,
                          onTimeTap: _pickTime,
                          onRepeatTap: _showCalendarSyncDialog,
                        ),
                        SizedBox(height: 24.h),

                        DurationSelectionRow(
                          selectedDuration: "00:15",
                          options: const ["00:15", "00:30", "00:45"],
                          onDurationSelected: (val) {},
                          onSetCustom: () {},
                        ),
                        SizedBox(height: 24.h),

                        const Divider(height: 1),
                        SizedBox(height: 24.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Icon(
                                Icons.paste_outlined,
                                color: Colors.grey[400],
                                size: 18.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: 'Roboto Flex',
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Add notes",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Roboto Flex',
                                    color: Colors.grey[400],
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        const Divider(height: 1),
                        SizedBox(height: 24.h),

                        TagsInputRow(
                          tags: _tags,
                          onRemoveTag: _removeTag,
                          onAddTag: _addTag,
                        ),
                        SizedBox(height: 24.h),

                        const Divider(height: 1),
                        SizedBox(height: 24.h),

                        EnjoymentPurposeSliders(
                          enjoymentLabel: "Medium",
                          purposeLabel: "Excitement",
                          onEnjoymentTap: () {},
                          onPurposeTap: () {},
                        ),
                        SizedBox(height: 24.h),

                        const Divider(height: 1),
                        SizedBox(height: 12.h),

                        NotificationSettingsRow(
                          notificationTime: "15 minutes before",
                          isEnabled: _isNotificationEnabled,
                          onToggle: (val) {
                            setState(() {
                              _isNotificationEnabled = val;
                            });
                          },
                        ),
                        SizedBox(height: 12.h),

                        Center(
                          child: Container(
                            width: 60.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBEBF9),
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Icon(
                              Icons.add,
                              color: const Color(0xFF5856D6),
                              size: 24.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                      ],
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
