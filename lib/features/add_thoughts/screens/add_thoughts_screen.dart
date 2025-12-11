import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/features/add_task/widgets/action_grid_buttons.dart';
import 'package:tea_assignment/features/add_task/widgets/date_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/header_section.dart';
import 'package:tea_assignment/features/add_task/widgets/simple_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/tags_input_row.dart';

class AddThoughtsScreen extends StatelessWidget {
  const AddThoughtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddThoughtsSheet());
  }
}

class AddThoughtsSheet extends StatefulWidget {
  const AddThoughtsSheet({super.key});

  @override
  State<AddThoughtsSheet> createState() => _AddThoughtsSheetState();
}

class _AddThoughtsSheetState extends State<AddThoughtsSheet> {
  final List<String> _tags = ["Tag_1", "Tag_1"];
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _location = "";

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
              child: const HeaderSection(hintText: "Name your thought"),
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

                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: TextField(
                        controller: _noteController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: "Write your new thought here...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    const Divider(height: 1),
                    SizedBox(height: 24.h),

                    SimpleInputRow(
                      icon: Icons.link,
                      hint: "Add Link",
                      actionLabel: "Add",
                      actionIcon: Icons.add,
                      onActionTap: () {},
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
}
