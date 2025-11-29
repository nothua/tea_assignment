import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeRangePicker extends StatelessWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final ValueChanged<TimeOfDay> onStartTimeChanged;
  final ValueChanged<TimeOfDay> onEndTimeChanged;

  const TimeRangePicker({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
  });

  Future<void> _selectTime(
    BuildContext context,
    TimeOfDay initialTime,
    ValueChanged<TimeOfDay> onTimePicked,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.sliderActive,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.sliderActive,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onTimePicked(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildTimeButton(
            context,
            startTime,
            (time) => onStartTimeChanged(time),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding12),
          child: Text(
            'to',
            style: GoogleFonts.dmSans(
              fontSize: AppDimensions.fontSize16,
              fontWeight: FontWeight.w500,
              color: AppColors.textGrey,
            ),
          ),
        ),
        Expanded(
          child: _buildTimeButton(
            context,
            endTime,
            (time) => onEndTimeChanged(time),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeButton(
    BuildContext context,
    TimeOfDay time,
    ValueChanged<TimeOfDay> onTap,
  ) {
    return GestureDetector(
      onTap: () => _selectTime(context, time, onTap),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppDimensions.padding12,
          horizontal: AppDimensions.padding16,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderGrey),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time,
              size: AppDimensions.iconSize22,
              color: AppColors.textBlack87,
            ),
            SizedBox(width: AppDimensions.spacing8),
            Text(
              time.format(context),
              style: GoogleFonts.outfit(
                fontSize: AppDimensions.fontSize16,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
