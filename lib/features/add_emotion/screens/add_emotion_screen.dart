import 'package:flutter/material.dart';
import 'package:tea_assignment/features/add_task/widgets/date_selection_row.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/add_task/widgets/action_grid_buttons.dart';
import 'package:tea_assignment/features/add_task/widgets/header_section.dart';
import 'package:tea_assignment/features/add_task/widgets/simple_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/tags_input_row.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';

class AddEmotionScreen extends StatelessWidget {
  const AddEmotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddEmotionSheet());
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

  void _setLocation() {
    showDialog(
      context: context,
      builder: (context) {
        String newLocation = _location;
        return AlertDialog(
          title: const Text("Set Location"),
          content: TextField(
            autofocus: true,
            onChanged: (value) => newLocation = value,
            decoration: const InputDecoration(hintText: "Enter location"),
            controller: TextEditingController(text: _location),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _location = newLocation;
                });
                Navigator.pop(context);
              },
              child: const Text("Set"),
            ),
          ],
        );
      },
    );
  }

  String get _formattedDate {
    return "${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}";
  }

  String get _formattedTime {
    return _selectedTime.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 10.h),
              child: const HeaderSection(hintText: "Name your emotion"),
            ),

            const Divider(height: 1),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: TextField(
                        controller: _noteController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: "How are you feeling today?",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
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

                    SizedBox(height: 30.h),

                    ActionGridButtons(
                      onLocationTap: _setLocation,
                      onCompaniesTap: () {},
                      onContactsTap: () {},
                      onAttachmentsTap: () {},
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
                      fontSize: 18.sp,
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
                        ),
                        _buildSegmentOption(
                          "Mixed",
                          1,
                          Colors.grey,
                          setModalState,
                        ),
                        _buildSegmentOption(
                          "Negative",
                          2,
                          Colors.red,
                          setModalState,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Emotions",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _moodEmotions[_selectedMoodIndex]!
                            .map(
                              (emotion) =>
                                  _buildMoodChip(emotion, setModalState),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: CustomButton(
                      text: "Done",
                      onPressed: () => Navigator.pop(context),
                      width: double.infinity,
                      height: 48.h,
                      backgroundColor: AppColors.loginButtonColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      setState(() {}); // Update main screen when sheet closes
    });
  }

  Widget _buildSegmentOption(
    String label,
    int index,
    Color activeColor,
    StateSetter setModalState,
  ) {
    final isSelected = _selectedMoodIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setModalState(() {
            _selectedMoodIndex = index;
            _selectedEmotion = null; // Reset emotion when mood changes
          });
          setState(() {
            _selectedMoodIndex = index;
            _selectedEmotion = null;
          });
        },
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

  Widget _buildMoodChip(String label, StateSetter setModalState) {
    final isSelected = _selectedEmotion == label;
    return GestureDetector(
      onTap: () {
        setModalState(() {
          _selectedEmotion = label;
        });
        setState(() {
          _selectedEmotion = label;
        });
      },
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
                ? _getMoodColor(_selectedMoodIndex)
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
                ? _getMoodColor(_selectedMoodIndex)
                : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
