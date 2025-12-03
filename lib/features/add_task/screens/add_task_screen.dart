import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/add_task/widgets/action_grid_buttons.dart';
import 'package:tea_assignment/features/add_task/widgets/date_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/duration_selection_row.dart';
import 'package:tea_assignment/features/add_task/widgets/enjoyment_purpose_sliders.dart';
import 'package:tea_assignment/features/add_task/widgets/header_section.dart';
import 'package:tea_assignment/features/add_task/widgets/notification_settings_row.dart';
import 'package:tea_assignment/features/add_task/widgets/simple_input_row.dart';
import 'package:tea_assignment/features/add_task/widgets/tags_input_row.dart';
import 'package:tea_assignment/shared/widgets/selectable_chip.dart';

class TaskCreationScreen extends StatelessWidget {
  const TaskCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 10.h),
                child: const HeaderSection(),
              ),

              const Divider(height: 1),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SelectableChip(label: "Early Morning", isSelected: false, onTap: () {}),
                            SizedBox(width: 8.w),
                            SelectableChip(label: "Morning", isSelected: false, onTap: () {}),
                            SizedBox(width: 8.w),
                            SelectableChip(label: "Afternoon", isSelected: false, onTap: () {}),
                            SizedBox(width: 8.w),
                            SelectableChip(label: "Evening", isSelected: false, onTap: () {}),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      
                      DateSelectionRow(
                        date: "October 15, 2025",
                        time: "hh:mm AM",
                        onDateTap: () {},
                        onTimeTap: () {},
                        onRepeatTap: () {},
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
                        children: [
                          Icon(Icons.edit_note_outlined, color: Colors.grey[400], size: 24.sp),
                          SizedBox(width: 16.w),
                          Text("Add notes", style: TextStyle(color: Colors.grey[400], fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      const Divider(height: 1),
                      SizedBox(height: 24.h),

                      
                      TagsInputRow(
                        tags: const ["Tag_1", "Tag_1", "Tag_1"],
                        onRemoveTag: (tag) {},
                        onAddTag: () {},
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
                      SizedBox(height: 24.h),

                      
                      NotificationSettingsRow(
                        notificationTime: "15 minutes before",
                        isEnabled: true,
                        onToggle: (val) {},
                      ),
                      SizedBox(height: 24.h),

                      const Divider(height: 1),
                      SizedBox(height: 24.h),

                      
                      SimpleInputRow(
                        icon: Icons.location_on_outlined,
                        hint: "Location",
                        actionLabel: "Map",
                        actionIcon: Icons.map_outlined,
                        onActionTap: () {},
                      ),
                      SizedBox(height: 24.h),

                      const Divider(height: 1),
                      SizedBox(height: 24.h),

                      
                      SimpleInputRow(
                        icon: Icons.domain_outlined,
                        hint: "Companies",
                        actionLabel: "Add",
                        actionIcon: Icons.add,
                        onActionTap: () {},
                      ),

                      SizedBox(height: 30.h),

                      
                      ActionGridButtons(
                        onLocationTap: () {},
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
      ),
    );
  }
}
