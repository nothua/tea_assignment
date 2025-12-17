import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';

import 'package:tea_assignment/features/add_task/widgets/duration_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/notification_settings_row.dart';
import 'package:tea_assignment/features/add_task/widgets/header_section.dart';
import 'package:tea_assignment/features/add_task/widgets/tags_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/common_action_rows.dart';
import 'package:tea_assignment/features/add_task/widgets/action_grid_buttons.dart';
import 'package:tea_assignment/features/add_task/widgets/simple_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/task_entry_content.dart';
import 'package:tea_assignment/features/add_task/widgets/repeat_frequency_sheet.dart';
import 'package:tea_assignment/features/add_task/screens/add_task_screen.dart';

import 'package:tea_assignment/shared/widgets/selectable_chip.dart';
import 'package:tea_assignment/shared/widgets/circle_icon_button.dart';
import 'package:tea_assignment/features/routines/widgets/suggested_task_chip.dart';
import 'package:tea_assignment/features/routines/widgets/compact_task_item.dart';

class EditRoutineScreen extends StatelessWidget {
  const EditRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyF2,
      body: SafeArea(
        child: TaskEntryContent(
          title: "Edit Routine",
          onClose: () => Navigator.pop(context),
          onCheck: () {
            // Save logic here
            Navigator.pop(context);
          },
          child: const EditRoutineContent(),
        ),
      ),
    );
  }
}

class EditRoutineContent extends StatefulWidget {
  const EditRoutineContent({super.key});

  @override
  State<EditRoutineContent> createState() => _EditRoutineContentState();
}

class _EditRoutineContentState extends State<EditRoutineContent> {
  final TextEditingController _notesController = TextEditingController();

  // State variables
  String? _selectedTimePeriod;
  DateTime _selectedDate = DateTime(2025, 10, 15);
  TimeOfDay? _selectedTime = null;
  String _notificationTime = "15 minutes before";
  bool _isNotificationEnabled = true;
  final List<String> _tags = ["Tag_1"];

  // New State Variables
  String? _repeatFrequency;
  DateTime? _repeatEndDate;
  // Changed to store Map for state persistence
  final List<Map<String, dynamic>> _associatedTasks = [];

  // Action Visibility State
  bool _showLocation = true;
  bool _showCompanies = true;
  bool _showAttachments = false;
  bool _showLinks = false;
  bool _showAssociated = false;
  bool _showContacts = false;

  // Suggested Tasks
  final List<String> _suggestedTasks = [
    "Day Planning",
    "Breakfast",
    "Exercise",
    "Shower",
  ];

  String get _formattedDate {
    return DateFormat('MMMM d, yyyy').format(_selectedDate);
  }

  void _openRepeatFrequencySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RepeatFrequencySheet(
        initialFrequency: _repeatFrequency ?? "Daily",
        initialStartDate: DateTime.now(),
        initialEndDate: _repeatEndDate,
        onSave: (frequency, _, endDate) {
          setState(() {
            _repeatFrequency = frequency;
            _repeatEndDate = endDate;
          });
        },
      ),
    );
  }

  void _openAddTaskSheet({String? initialTitle, int? editIndex}) {
    final TextEditingController controller = TextEditingController(
      text: initialTitle,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 0.85.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        clipBehavior: Clip.antiAlias,
        child: TaskEntryContent(
          title: initialTitle != null ? "Edit Task" : "Add Task",
          onClose: () => Navigator.pop(context),
          onCheck: () {
            if (controller.text.isNotEmpty) {
              setState(() {
                if (editIndex != null) {
                  // Editing existing task
                  _associatedTasks[editIndex]['title'] = controller.text;
                } else {
                  // Adding new task
                  if (initialTitle != null) {
                    // If adding suggested, remove old title if it was in suggested
                    _suggestedTasks.remove(initialTitle);
                  }
                  _associatedTasks.add({
                    'title': controller.text,
                    'isChecked': false,
                  });
                }
              });
            }
            Navigator.pop(context);
          },
          showHeader: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              // Drag Handle
              Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5EA),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              // Title
              Text(
                initialTitle != null ? "Edit Task" : "Add Task",
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF12112B),
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: TaskCreationSheet(
                  controller: controller,
                  isRoutineTask: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickRepeatUntilDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _repeatEndDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _repeatEndDate = picked;
      });
    }
  }

  void _addTag() {
    // Placeholder for add tag dialog
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _selectTimePeriod(String period) {
    setState(() {
      _selectedTimePeriod = period;
    });
  }

  Future<void> _pickDate() async {
    // Date picker implementation if needed
  }

  Future<void> _pickTime() async {
    // Time picker implementation if needed
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(8.w, 16.h, 8.w, 32.h),
      physics: const BouncingScrollPhysics(),
      children: [
        // White Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 10.h),
                child: const HeaderSection(hintText: "Name your routine"),
              ),
              const Divider(height: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Repeating Frequency (Moved to top)
                    SimpleInputRow(
                      svgIcon: "assets/images/icons/refresh-2.svg",
                      hint: "Repeating Frequency",
                      actionLabel: _repeatFrequency ?? "Does not repeat",
                      onActionTap: _openRepeatFrequencySheet,
                    ),
                    SizedBox(height: 24.h),
                    const Divider(height: 1),
                    SizedBox(height: 24.h),

                    // Repeats Until (Moved to top)
                    SimpleInputRow(
                      svgIcon: "assets/images/icons/calender.svg",
                      hint: "Repeats Until",
                      actionLabel: _repeatEndDate != null
                          ? DateFormat('MMMM d, yyyy').format(_repeatEndDate!)
                          : "Never Ends",
                      actionIcon: _repeatEndDate == null
                          ? Icons.all_inclusive
                          : null,
                      onActionTap: _pickRepeatUntilDate,
                    ),
                    SizedBox(height: 24.h),
                    const Divider(height: 1),
                    SizedBox(height: 24.h),

                    // Time Periods
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          _buildTimeChip("Early Morning", "early_morning.svg"),
                          SizedBox(width: 8.w),
                          _buildTimeChip("Morning", "morning.svg"),
                          SizedBox(width: 8.w),
                          _buildTimeChip("Afternoon", "afternoon.svg"),
                          SizedBox(width: 8.w),
                          _buildTimeChip("Evening", "evening.svg"),
                          SizedBox(width: 8.w),
                          _buildTimeChip("Night", "night.svg"),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Date/Time Selection
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/icons/calender.svg",
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF8E8E93),
                                  BlendMode.srcIn,
                                ),
                                width: 18.sp,
                                height: 18.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "*",
                                style: TextStyle(
                                  color: AppColors.iconRed,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Flexible(
                                child: GestureDetector(
                                  onTap: _pickDate,
                                  child: Text(
                                    _formattedDate,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Roboto Flex',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: const Color(0xFF12112B),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CircleIconButton(
                                svgIcon:
                                    "assets/images/icons/clock.svg", // Updated to clock.svg
                                size: 34.w,
                                iconSize: 18.sp,
                                color: AppColors.greyF7,
                                iconColor: const Color(0xFF8E8E93),
                                onTap: _pickTime,
                                boxShadow: const [],
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                _selectedTime?.format(context) ?? "hh:mm AM",
                                style: TextStyle(
                                  fontFamily: 'Roboto Flex',
                                  fontSize: 14.sp,
                                  color: const Color(0xFFAEAEB2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Duration
                    DurationSelectionRow(
                      selectedDuration: "00:15",
                      options: const ["00:15", "00:30", "00:45"],
                      onDurationSelected: (val) {},
                      onSetCustom: () {},
                    ),
                    SizedBox(height: 24.h),
                    const Divider(height: 1),
                    SizedBox(height: 24.h),

                    // Notes
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 3.w),
                        SvgPicture.asset(
                          "assets/images/icons/stickynote.svg",
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF8E8E93),
                            BlendMode.srcIn,
                          ),
                          width: 16.sp,
                          height: 16.sp,
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: TextField(
                            controller: _notesController,
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

                    // Tags
                    TagsInputRow(
                      tags: _tags,
                      onRemoveTag: _removeTag,
                      onAddTag: _addTag,
                    ),
                    SizedBox(height: 24.h),
                    const Divider(height: 1),
                    SizedBox(height: 18.h),

                    // Notification
                    NotificationSettingsRow(
                      notificationTime: _notificationTime,
                      isEnabled: _isNotificationEnabled,
                      onToggle: (val) {
                        setState(() {
                          _isNotificationEnabled = val;
                        });
                      },
                      onTimeTap: () {},
                    ),
                    SizedBox(height: 18.h),
                    const Divider(height: 1),
                    SizedBox(height: 24.h),

                    // Action Rows (Location, Companies etc.)
                    CommonActionRows(
                      showLocation: _showLocation,
                      showCompanies: _showCompanies,
                      showAttachments: _showAttachments,
                      showLinks: _showLinks,
                      showAssociated: _showAssociated,
                      showContacts: _showContacts,
                    ),

                    // Bottom Grid Buttons
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
                      onAssociatedTap: () {
                        setState(() {
                          _showAssociated = !_showAssociated;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),
                    const Divider(height: 1),
                    SizedBox(height: 16.h),

                    // Associated Tasks (Moved to Bottom)
                    SizedBox(height: 12.h),
                    Text(
                      "Tasks Within Routine (${_associatedTasks.length})",
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        color: const Color(0xFF1A1A1A),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _associatedTasks.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        return CompactTaskItem(
                          title: _associatedTasks[index]['title'],
                          onEdit: () {
                            _openAddTaskSheet(
                              initialTitle: _associatedTasks[index]['title'],
                              editIndex: index,
                            );
                          },
                          onDelete: () {
                            setState(() {
                              _associatedTasks.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _openAddTaskSheet(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9B82FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 18.h),
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
                    SizedBox(height: 24.h),
                    const Divider(height: 1),
                    SizedBox(height: 24.h),

                    // Suggested Tasks
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Suggested Tasks",
                          style: TextStyle(
                            fontFamily: 'Roboto Flex',
                            fontSize: 16.sp,
                            color: const Color(
                              0xFF1A1A1A,
                            ), // Matches View Routines title color
                            fontWeight:
                                FontWeight.w600, // Matches View Routines weight
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: _suggestedTasks.map((task) {
                            return SuggestedTaskChip(
                              label: task,
                              onTap: () =>
                                  _openAddTaskSheet(initialTitle: task),
                              isSelected: false, // Default to unselected style
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeChip(String label, String iconName) {
    bool isSelected = _selectedTimePeriod == label;
    return SelectableChip(
      label: label,
      isSelected: isSelected,
      onTap: () => _selectTimePeriod(label),
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto Flex',
      unselectedTextColor: const Color(0xFF8E8E93),
      iconPath: "assets/images/icons/$iconName",
    );
  }
}
