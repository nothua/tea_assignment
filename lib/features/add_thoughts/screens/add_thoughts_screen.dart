import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/features/add_task/widgets/action_grid_buttons.dart';
import 'package:tea_assignment/features/add_task/widgets/date_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/header_section.dart';
import 'package:tea_assignment/features/add_task/widgets/simple_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/tags_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/task_entry_content.dart';
import 'package:intl/intl.dart';
import 'package:tea_assignment/features/add_task/widgets/voice_entry_bottom_bar.dart';
import 'package:tea_assignment/features/add_task/widgets/add_tag_dialog.dart';
import 'package:tea_assignment/features/add_task/widgets/common_action_rows.dart';
import 'package:tea_assignment/shared/widgets/boxed_text_field.dart';

class AddThoughtsScreen extends StatelessWidget {
  const AddThoughtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskEntryContent(
      title: "Add Thoughts",
      onClose: () => Navigator.pop(context),
      showHeader: false,
      child: const AddThoughtsSheet(),
    );
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

  // Visibility states for action fields
  bool _showLocation = false;
  bool _showCompanies = false;
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
                          hintText: "Name your thought",
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
                            BoxedTextField(
                              controller: _noteController,
                              hintText: "Write your new thought here...",
                              maxLines: 6,
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
}
