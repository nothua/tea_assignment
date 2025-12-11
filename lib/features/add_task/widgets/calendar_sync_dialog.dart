import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tea_assignment/shared/widgets/custom_switch.dart';

class CalendarSyncDialog extends StatefulWidget {
  const CalendarSyncDialog({super.key});

  @override
  State<CalendarSyncDialog> createState() => _CalendarSyncDialogState();
}

class _CalendarSyncDialogState extends State<CalendarSyncDialog> {
  bool _isSyncEnabled = true;
  String? _selectedCalendar = 'google'; // 'google' or 'teams'

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sync with Calendar",
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF12112B),
                  ),
                ),
                CustomSwitch(
                  value: _isSyncEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isSyncEnabled = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "Select a calendar app to add this task to",
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8E8E93),
              ),
            ),
            SizedBox(height: 24.h),
            const Divider(height: 1, color: Color(0xFFF2F2F7)),
            SizedBox(height: 16.h),
            _buildCalendarOption(
              id: 'google',
              name: "Google Calendar",
              icon:
                  Icons.calendar_month, // Placeholder for Google Calendar icon
              iconColor: Colors.blue,
            ),
            SizedBox(height: 16.h),
            _buildCalendarOption(
              id: 'teams',
              name: "Teams Calendar",
              icon: Icons.calendar_today, // Placeholder for Teams Calendar icon
              iconColor: Colors.indigo,
            ),
            SizedBox(height: 24.h),
            const Divider(height: 1, color: Color(0xFFF2F2F7)),
            SizedBox(height: 16.h),
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
                    // Handle sync confirmation
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarOption({
    required String id,
    required String name,
    required IconData icon,
    required Color iconColor,
  }) {
    final isSelected = _selectedCalendar == id;
    return GestureDetector(
      onTap: () {
        if (_isSyncEnabled) {
          setState(() {
            _selectedCalendar = id;
          });
        }
      },
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF12112B),
              ),
            ),
          ),
          if (_isSyncEnabled)
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFF5856D6)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF5856D6)
                      : const Color(0xFFE5E5EA),
                  width: 1,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
        ],
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
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 14.sp),
      ),
    );
  }
}
