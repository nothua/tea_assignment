import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/features/add_task/widgets/task_entry_content.dart';
import 'package:tea_assignment/features/add_task/screens/add_task_screen.dart';

class SubTaskScreen extends StatelessWidget {
  final String parentTaskTitle;
  final String title;

  const SubTaskScreen({
    super.key,
    required this.parentTaskTitle,
    this.title = "Add Subtask",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyF2,
      body: SafeArea(
        child: TaskEntryContent(
          title: title,
          onClose: () => Navigator.pop(context),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
            onPressed: () => Navigator.pop(context),
          ),
          child: TaskCreationSheet(parentTaskTitle: parentTaskTitle),
        ),
      ),
    );
  }
}
