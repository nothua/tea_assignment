import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class RepeatFrequencySheet extends StatefulWidget {
  final String? initialFrequency;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(String frequency, DateTime? startDate, DateTime? endDate)
  onSave;

  const RepeatFrequencySheet({
    super.key,
    this.initialFrequency,
    this.initialStartDate,
    this.initialEndDate,
    required this.onSave,
  });

  @override
  State<RepeatFrequencySheet> createState() => _RepeatFrequencySheetState();
}

class _RepeatFrequencySheetState extends State<RepeatFrequencySheet> {
  late String _selectedFrequency;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();
  bool _isNeverEnding = false;

  final List<String> _frequencies = [
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
    "Custom",
  ];

  @override
  void initState() {
    super.initState();
    _selectedFrequency = widget.initialFrequency ?? "Weekly";
    _rangeStart = widget.initialStartDate;
    _rangeEnd = widget.initialEndDate;
    if (_rangeEnd == null && _rangeStart != null) {}

    if (widget.initialEndDate == null) {
      _isNeverEnding = true;
    }

    _focusedDay = _rangeStart ?? DateTime.now();
  }

  void _showFrequencyPicker() {
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
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 14.sp,
                        color: const Color(0xFF12112B),
                      ),
                    ),
                  ),
                  Text(
                    "Repeat Frequency",
                    style: TextStyle(
                      fontFamily: 'Roboto Flex',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF12112B),
                    ),
                  ),
                  SizedBox(width: 48.w), // Spacer for centering
                ],
              ),
            ),
            SizedBox(height: 16.h),
            ..._frequencies.map(
              (freq) => ListTile(
                leading: Icon(
                  Icons.sync,
                  color: _selectedFrequency == freq
                      ? const Color(0xFFE94E34)
                      : const Color(0xFF8E52AC),
                  size: 20.sp,
                ),
                title: Text(
                  freq,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 14.sp,
                    color: const Color(0xFF12112B),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedFrequency = freq;
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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

          // Header
          Text(
            "Repeat Task",
            style: TextStyle(
              fontFamily: 'Roboto Flex',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF12112B),
            ),
          ),
          SizedBox(height: 24.h),

          // Frequency Selector
          GestureDetector(
            onTap: _showFrequencyPicker,
            child: Row(
              children: [
                Icon(Icons.sync, size: 20.sp, color: const Color(0xFF12112B)),
                SizedBox(width: 12.w),
                Text(
                  "Repeat Frequency",
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF12112B),
                  ),
                ),
                const Spacer(),
                Text(
                  _selectedFrequency,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 12.sp,
                    color: const Color(0xFF8E8E93),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.chevron_right,
                  size: 16.sp,
                  color: const Color(0xFF8E8E93),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Calendar
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(16.w),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
                leftChevronIcon: Icon(Icons.chevron_left, size: 20.sp),
                rightChevronIcon: Icon(Icons.chevron_right, size: 20.sp),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(
                  color: Color(0xFFB4B3EC),
                  shape: BoxShape.circle,
                ),
                rangeStartDecoration: const BoxDecoration(
                  color: Color(0xFF8E52AC),
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: const BoxDecoration(
                  color: Color(0xFF8E52AC),
                  shape: BoxShape.circle,
                ),
                rangeHighlightColor: const Color(
                  0xFFF3E5F5,
                ), // Light purple range
                defaultTextStyle: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 12.sp,
                ),
                weekendTextStyle: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 12.sp,
                ),
              ),
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _isNeverEnding = false;
                  _rangeStart = start;
                  _rangeEnd = end;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          SizedBox(height: 24.h),

          // Never Ending Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                _isNeverEnding = !_isNeverEnding;
                if (_isNeverEnding) {
                  _rangeEnd = null;
                  // Keep rangeStart as is, or reset? Usually keep start date.
                }
              });
            },
            child: Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: const Color(0xFF8E8E93),
                      width: 1.5,
                    ),
                  ),
                  child: _isNeverEnding
                      ? Center(
                          child: Icon(
                            Icons.check,
                            size: 16.sp,
                            color: const Color(0xFF8E8E93),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Never Ending",
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF12112B),
                      ),
                    ),
                    Text(
                      "Task repeats indefinitely",
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 12.sp,
                        color: const Color(0xFF8E8E93),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: const Color(0xFFAEAEB2),
                    size: 24.sp,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onSave(
                    _selectedFrequency,
                    _rangeStart,
                    _isNeverEnding ? null : _rangeEnd,
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6CEAC0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 24.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
