import 'package:flutter/material.dart';
import 'package:tea_assignment/features/add_task/widgets/date_selection_row.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/add_task/widgets/action_grid_buttons.dart';
import 'package:tea_assignment/features/add_task/widgets/header_section.dart';
import 'package:tea_assignment/features/add_task/widgets/simple_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/tags_input_row.dart';

import 'package:tea_assignment/features/add_task/widgets/task_entry_content.dart';
import 'package:intl/intl.dart';
import 'package:tea_assignment/features/add_task/widgets/voice_entry_bottom_bar.dart';
import 'package:tea_assignment/features/add_task/widgets/add_tag_dialog.dart';
import 'package:tea_assignment/features/add_task/widgets/common_action_rows.dart';
import 'package:tea_assignment/shared/widgets/boxed_text_field.dart';

class AddEmotionScreen extends StatelessWidget {
  const AddEmotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskEntryContent(
      title: "Add Emotion",
      onClose: () => Navigator.pop(context),
      showHeader: false,
      child: const AddEmotionSheet(),
    );
  }
}

class AddEmotionSheet extends StatefulWidget {
  const AddEmotionSheet({super.key});

  @override
  State<AddEmotionSheet> createState() => _AddEmotionSheetState();
}

class _AddEmotionSheetState extends State<AddEmotionSheet> {
  final List<String> _tags = ["Tag_1", "Tag_1"];
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _location = "";
  int _selectedMoodIndex = 0;
  String? _selectedEmotion;

  // Visibility states for action fields
  bool _showLocation = false;
  bool _showCompanies = false;
  bool _showAttachments = false;
  bool _showLinks = false;
  bool _showAssociated = false;
  bool _showContacts = false;

  final Map<int, List<String>> _moodEmotions = {
    0: [
      "Admiration",
      "Calmness",
      "Excitement",
      "Interest",
      "Joy",
      "Romance",
      "Satisfaction",
      "Hope",
      "Love",
      "Gratitude",
    ],
    1: [
      "Confusion",
      "Nostalgia",
      "Surprise",
      "Sympathy",
      "Awkwardness",
      "Boredom",
      "Amusement",
    ],
    2: [
      "Anger",
      "Anxiety",
      "Disgust",
      "Fear",
      "Sadness",
      "Shame",
      "Guilt",
      "Envy",
      "Frustration",
    ],
  };

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
      });
    }
  }

  String get _formattedDate {
    return DateFormat('MMMM d, yyyy').format(_selectedDate);
  }

  String get _formattedTime {
    return _selectedTime.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.fromLTRB(8.w, 16.h, 8.w, 80.h),
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
                        child: const HeaderSection(
                          hintText: "Name your emotion",
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
                            DateSelectionRow(
                              date: _formattedDate,
                              time: _formattedTime,
                              onDateTap: _pickDate,
                              onTimeTap: _pickTime,
                              onRepeatTap: () {},
                            ),
                            SizedBox(height: 24.h),
                            const Divider(height: 1),
                            SizedBox(height: 24.h),
                            SimpleInputRow(
                              icon: _getMoodIcon(_selectedMoodIndex),
                              hint: _selectedEmotion != null
                                  ? "${_getMoodLabel(_selectedMoodIndex)} • $_selectedEmotion"
                                  : _getMoodLabel(_selectedMoodIndex),
                              actionLabel: "Select",
                              actionIcon: Icons.keyboard_arrow_down,
                              onActionTap: _showMoodSelectionSheet,
                            ),
                            SizedBox(height: 24.h),
                            const Divider(height: 1),
                            SizedBox(height: 24.h),
                            // Note Input
                            BoxedTextField(
                              controller: _noteController,
                              hintText: "How are you feeling today?",
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
                            CommonActionRows(
                              showLocation: _showLocation,
                              showCompanies: _showCompanies,
                              showAttachments: _showAttachments,
                              showLinks: _showLinks,
                              showAssociated: _showAssociated,
                              showContacts: _showContacts,
                            ),
                            ActionGridButtons(
                              // isLocationSelected: _showLocation,
                              // onLocationTap: () {
                              //   setState(() {
                              //     _showLocation = !_showLocation;
                              //   });
                              // },
                              // isCompaniesSelected: _showCompanies,
                              // onCompaniesTap: () {
                              //   setState(() {
                              //     _showCompanies = !_showCompanies;
                              //   });
                              // },
                              // isContactsSelected: _showContacts,
                              // onContactsTap: () {
                              //   setState(() {
                              //     _showContacts = !_showContacts;
                              //   });
                              // },
                              isAttachmentsSelected: _showAttachments,
                              onAttachmentsTap: () {
                                setState(() {
                                  _showAttachments = !_showAttachments;
                                });
                              },
                              // isLinksSelected: _showLinks,
                              // onLinksTap: () {
                              //   setState(() {
                              //     _showLinks = !_showLinks;
                              //   });
                              // },
                              // isAssociatedSelected: _showAssociated,
                              // onAssociatedTap: () {
                              //   setState(() {
                              //     _showAssociated = !_showAssociated;
                              //   });
                              // },
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
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: VoiceEntryBottomBar(
            onClose: () => Navigator.pop(context),
            onCheck: () {
              // Handle save
              Navigator.pop(context);
            },
            onVoiceEntry: () {
              // Handle voice entry
            },
          ),
        ),
      ],
    );
  }

  String _getMoodLabel(int index) {
    switch (index) {
      case 0:
        return "Positive";
      case 1:
        return "Mixed";
      case 2:
        return "Negative";
      default:
        return "Positive";
    }
  }

  Color _getMoodColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFF10B981);
      case 1:
        return Colors.grey;
      case 2:
        return Colors.red;
      default:
        return const Color(0xFF10B981);
    }
  }

  IconData _getMoodIcon(int index) {
    switch (index) {
      case 0:
        return Icons.sentiment_satisfied_alt;
      case 1:
        return Icons.sentiment_neutral;
      case 2:
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_satisfied_alt;
    }
  }

  void _showMoodSelectionSheet() {
    // Initialize temporary state
    int tempMoodIndex = _selectedMoodIndex;
    String? tempEmotion = _selectedEmotion;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Select Mood",
                    style: TextStyle(
                      fontFamily: 'Roboto Flex',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Segmented Control
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        _buildSegmentOption(
                          "Positive",
                          0,
                          const Color(0xFF10B981),
                          setModalState,
                          tempMoodIndex,
                          (index) {
                            setModalState(() {
                              tempMoodIndex = index;
                              tempEmotion = null;
                            });
                          },
                        ),
                        _buildSegmentOption(
                          "Mixed",
                          1,
                          Colors.grey,
                          setModalState,
                          tempMoodIndex,
                          (index) {
                            setModalState(() {
                              tempMoodIndex = index;
                              tempEmotion = null;
                            });
                          },
                        ),
                        _buildSegmentOption(
                          "Negative",
                          2,
                          Colors.red,
                          setModalState,
                          tempMoodIndex,
                          (index) {
                            setModalState(() {
                              tempMoodIndex = index;
                              tempEmotion = null;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Emotions",
                    style: TextStyle(
                      fontFamily: 'Roboto Flex',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _moodEmotions[tempMoodIndex]!
                            .map(
                              (emotion) => _buildMoodChip(
                                emotion,
                                setModalState,
                                tempEmotion,
                                tempMoodIndex,
                                (emotion) {
                                  setModalState(() {
                                    tempEmotion = emotion;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionButton(
                        icon: Icons.close,
                        color: const Color(0xFFF2F2F7),
                        iconColor: const Color(0xFFAEAEB2),
                        onTap: () => Navigator.pop(context),
                      ),
                      _buildActionButton(
                        icon: Icons.check,
                        color: const Color(0xFF5856D6),
                        iconColor: Colors.white,
                        onTap: () {
                          // Save changes
                          setState(() {
                            _selectedMoodIndex = tempMoodIndex;
                            _selectedEmotion = tempEmotion;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSegmentOption(
    String label,
    int index,
    Color activeColor,
    StateSetter setModalState,
    int currentMoodIndex,
    Function(int) onSelect,
  ) {
    final isSelected = currentMoodIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelect(index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodChip(
    String label,
    StateSetter setModalState,
    String? currentEmotion,
    int currentMoodIndex,
    Function(String) onSelect,
  ) {
    final isSelected = currentEmotion == label;
    return GestureDetector(
      onTap: () => onSelect(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryPurple.withValues(alpha: 0.1)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? _getMoodColor(currentMoodIndex)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? _getMoodColor(currentMoodIndex)
                : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 18.sp),
      ),
    );
  }
}
