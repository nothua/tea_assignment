import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/add_task/widgets/notification_settings_row.dart';
import 'package:tea_assignment/features/add_task/widgets/tags_input_row.dart';
import 'package:tea_assignment/shared/widgets/selectable_chip.dart';
import 'package:intl/intl.dart';

import 'package:tea_assignment/features/add_task/widgets/action_grid_buttons.dart';
import 'package:tea_assignment/features/add_task/widgets/add_tag_dialog.dart';
import 'package:tea_assignment/features/add_task/widgets/calendar_sync_dialog.dart';
import 'package:tea_assignment/features/add_task/widgets/common_action_rows.dart';
import 'package:tea_assignment/features/add_task/widgets/date_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/duration_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/enjoyment_purpose_sliders.dart';
import 'package:tea_assignment/features/add_task/widgets/header_section.dart';
import 'package:tea_assignment/features/add_task/widgets/simple_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/task_entry_content.dart';
import 'package:tea_assignment/features/add_task/widgets/repeat_frequency_sheet.dart';
import 'package:tea_assignment/features/add_task/widgets/parent_task_indicator.dart';

class TaskCreationScreen extends StatelessWidget {
  const TaskCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyF2,
      body: SafeArea(
        child: TaskEntryContent(
          title: "Add new Task",
          onClose: () => Navigator.pop(context),
          child: const TaskCreationSheet(),
        ),
      ),
    );
  }
}

class TaskCreationSheet extends StatefulWidget {
  final String? parentTaskTitle;

  const TaskCreationSheet({super.key, this.parentTaskTitle});

  @override
  State<TaskCreationSheet> createState() => _TaskCreationSheetState();
}

class _TaskCreationSheetState extends State<TaskCreationSheet> {
  final List<String> _tags = ["Tag_1", "Tag_1", "Tag_1"];
  DateTime _selectedDate = DateTime(2025, 10, 15);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  String? _selectedTimePeriod;

  bool _isNotificationEnabled = true;
  String _notificationTime = "15 minutes before";

  // Repeat Task State
  String? _repeatFrequency;
  DateTime? _repeatEndDate;

  // Visibility states for action fields
  bool _showLocation = true;
  bool _showCompanies = true;
  bool _showAttachments = false;
  bool _showLinks = false;
  bool _showAssociated = false;
  bool _showContacts = false;

  void _addTag() {
    showAddTagDialog(context, (newTag) {
      setState(() {
        _tags.add(newTag);
      });
    });
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
        _selectedTimePeriod =
            null; // Clear preset selection if custom time is picked
      });
    }
  }

  void _selectTimePeriod(String period) {
    TimeOfDay newTime;
    switch (period) {
      case "Early Morning":
        newTime = const TimeOfDay(hour: 6, minute: 0);
        break;
      case "Morning":
        newTime = const TimeOfDay(hour: 9, minute: 0);
        break;
      case "Afternoon":
        newTime = const TimeOfDay(hour: 12, minute: 0);
        break;
      case "Evening":
        newTime = const TimeOfDay(hour: 17, minute: 0);
        break;
      case "Night":
        newTime = const TimeOfDay(hour: 21, minute: 0);
        break;
      case "Late Night":
        newTime = const TimeOfDay(hour: 0, minute: 0);
        break;
      default:
        newTime = _selectedTime;
    }

    setState(() {
      _selectedTimePeriod = period;
      _selectedTime = newTime;
    });
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

  void _showRepeatTaskDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RepeatFrequencySheet(
        initialFrequency: _repeatFrequency,
        initialStartDate: _selectedDate,
        initialEndDate: _repeatEndDate,
        onSave: (frequency, startDate, endDate) {
          setState(() {
            _repeatFrequency = frequency;
            if (startDate != null) {
              _selectedDate = startDate;
            }
            _repeatEndDate = endDate;
          });
        },
      ),
    );
  }

  void _showNotificationOptions() {
    final List<String> options = [
      "At time of event",
      "5 minutes before",
      "10 minutes before",
      "15 minutes before",
      "30 minutes before",
      "1 hour before",
      "1 day before",
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2F2F7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: const Color(0xFFAEAEB2),
                        size: 16.sp,
                      ),
                    ),
                  ),
                  Text(
                    "Notification Time",
                    style: TextStyle(
                      fontFamily: 'Roboto Flex',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF12112B),
                    ),
                  ),
                  SizedBox(width: 48.w),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            ...options.map(
              (option) => ListTile(
                title: Text(
                  option,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 14.sp,
                    color: const Color(0xFF12112B),
                  ),
                ),
                trailing: _notificationTime == option
                    ? Icon(Icons.check, color: const Color(0xFF6CEAC0))
                    : null,
                onTap: () {
                  setState(() {
                    _notificationTime = option;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.fromLTRB(8.w, 16.h, 8.w, 16.h),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.parentTaskTitle != null) ...[
                          ParentTaskIndicator(
                            parentTitle: widget.parentTaskTitle!,
                          ),
                          SizedBox(height: 16.h),
                        ],
                        const HeaderSection(),
                      ],
                    ),
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
                                isSelected:
                                    _selectedTimePeriod == "Early Morning",
                                onTap: () => _selectTimePeriod("Early Morning"),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFF8E8E93),
                                iconPath:
                                    "assets/images/icons/early_morning.svg",
                              ),
                              SizedBox(width: 8.w),
                              SelectableChip(
                                label: "Morning",
                                isSelected: _selectedTimePeriod == "Morning",
                                onTap: () => _selectTimePeriod("Morning"),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFF8E8E93),
                                iconPath: "assets/images/icons/morning.svg",
                              ),
                              SizedBox(width: 8.w),
                              SelectableChip(
                                label: "Afternoon",
                                isSelected: _selectedTimePeriod == "Afternoon",
                                onTap: () => _selectTimePeriod("Afternoon"),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFF8E8E93),
                                iconPath: "assets/images/icons/afternoon.svg",
                              ),
                              SizedBox(width: 8.w),
                              SelectableChip(
                                label: "Evening",
                                isSelected: _selectedTimePeriod == "Evening",
                                onTap: () => _selectTimePeriod("Evening"),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFF8E8E93),
                                iconPath: "assets/images/icons/evening.svg",
                              ),
                              SizedBox(width: 8.w),
                              SelectableChip(
                                label: "Night",
                                isSelected: _selectedTimePeriod == "Night",
                                onTap: () => _selectTimePeriod("Night"),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFF8E8E93),
                                iconPath: "assets/images/icons/night.svg",
                              ),
                              SizedBox(width: 8.w),
                              SelectableChip(
                                label: "Late Night",
                                isSelected: _selectedTimePeriod == "Late Night",
                                onTap: () => _selectTimePeriod("Late Night"),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto Flex',
                                unselectedTextColor: const Color(0xFF8E8E93),
                                iconPath: "assets/images/icons/last_night.svg",
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/icons/stickynote.svg",
                              colorFilter: const ColorFilter.mode(
                                Color(0xFF8E8E93),
                                BlendMode.srcIn,
                              ),
                              width: 18.sp,
                              height: 18.sp,
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
                        SimpleInputRow(
                          icon: Icons.flag_outlined,
                          hint: "Goal",
                          actionLabel: "Set Goal",
                          onActionTap: () {},
                        ),
                        SizedBox(height: 24.h),

                        const Divider(height: 1),
                        SizedBox(height: 24.h),

                        if (_repeatFrequency == null)
                          SimpleInputRow(
                            icon: Icons.repeat,
                            hint: "Repeat Task",
                            actionLabel: "Does not repeat",
                            onActionTap: _showRepeatTaskDialog,
                          )
                        else
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.repeat,
                                  color: Colors.grey[500],
                                  size: 18.sp,
                                ),
                                SizedBox(width: 13.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Frequency: $_repeatFrequency",
                                        style: TextStyle(
                                          fontFamily: 'Roboto Flex',
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        _repeatEndDate == null
                                            ? "Ends: Never"
                                            : "Ends: ${DateFormat('MMMM d, yyyy').format(_repeatEndDate!)}",
                                        style: TextStyle(
                                          fontFamily: 'Roboto Flex',
                                          fontSize: 12.sp,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _showRepeatTaskDialog,
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontFamily: 'Roboto Flex',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF12112B),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _repeatFrequency = null;
                                      _repeatEndDate = null;
                                    });
                                  },
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                      fontFamily: 'Roboto Flex',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFE94E34),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 24.h),

                        const Divider(height: 1),
                        SizedBox(height: 24.h),

                        SimpleInputRow(
                          icon: Icons.checklist,
                          hint: "Subtask",
                          actionLabel: "Add Subtask",
                          onActionTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                height: 0.85.sh,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.r),
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: TaskEntryContent(
                                  title: "Add Subtask",
                                  onClose: () => Navigator.pop(context),
                                  showHeader: false,
                                  showVoiceButton: false,
                                  child: TaskCreationSheet(
                                    parentTaskTitle: "Design Team Meeting",
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 24.h),

                        const Divider(height: 1),
                        SizedBox(height: 24.h),

                        SimpleInputRow(
                          icon: Icons.forward,
                          hint: "Follow up task",
                          actionLabel: "Add Follow up",
                          onActionTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                height: 0.85.sh,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.r),
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: TaskEntryContent(
                                  title: "Add Follow up",
                                  onClose: () => Navigator.pop(context),
                                  showHeader: false,
                                  showVoiceButton: false,
                                  child: TaskCreationSheet(
                                    parentTaskTitle: "Design Team Meeting",
                                  ),
                                ),
                              ),
                            );
                          },
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
                        ),
                        SizedBox(height: 24.h),

                        const Divider(height: 1),
                        SizedBox(height: 18.h),

                        NotificationSettingsRow(
                          notificationTime: _notificationTime,
                          isEnabled: _isNotificationEnabled,
                          onToggle: (val) {
                            setState(() {
                              _isNotificationEnabled = val;
                            });
                          },
                          onTimeTap: _showNotificationOptions,
                        ),
                        SizedBox(height: 18.h),

                        const Divider(height: 1),
                        SizedBox(height: 24.h),

                        CommonActionRows(
                          showLocation: _showLocation,
                          showCompanies: _showCompanies,
                          showAttachments: _showAttachments,
                          showLinks: _showLinks,
                          showAssociated: _showAssociated,
                          showContacts: _showContacts,
                        ),

                        ActionGridButtons(
                          isLocationSelected: _showLocation,
                          onLocationTap: () {
                            setState(() {
                              _showLocation = !_showLocation;
                            });
                          },
                          isCompaniesSelected: _showCompanies,
                          onCompaniesTap: () {
                            setState(() {
                              _showCompanies = !_showCompanies;
                            });
                          },
                          isContactsSelected: _showContacts,
                          onContactsTap: () {
                            setState(() {
                              _showContacts = !_showContacts;
                            });
                          },
                          isAttachmentsSelected: _showAttachments,
                          onAttachmentsTap: () {
                            setState(() {
                              _showAttachments = !_showAttachments;
                            });
                          },
                          isLinksSelected: _showLinks,
                          onLinksTap: () {
                            setState(() {
                              _showLinks = !_showLinks;
                            });
                          },
                          isAssociatedSelected: _showAssociated,
                          onAssociatedTap: () {
                            setState(() {
                              _showAssociated = !_showAssociated;
                            });
                          },
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
