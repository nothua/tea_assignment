import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/active_task/widgets/action_buttons_row.dart';
import 'package:tea_assignment/features/active_task/widgets/bottom_action_bar.dart';
import 'package:tea_assignment/features/active_task/widgets/circular_timer.dart';
import 'package:tea_assignment/features/active_task/widgets/distraction_task_card.dart';
import 'package:tea_assignment/features/active_task/widgets/task_metadata_row.dart';
import 'package:tea_assignment/shared/widgets/app_header.dart';
import 'package:tea_assignment/shared/widgets/circle_icon_button.dart';
import 'package:tea_assignment/shared/widgets/status_badge.dart';
import 'package:tea_assignment/features/active_task/widgets/add_menu_bottom_sheet.dart';

class DistractionEntry {
  final String title;
  final String duration;
  final String dateTime;

  DistractionEntry({
    required this.title,
    required this.duration,
    required this.dateTime,
  });
}

class ActiveTaskScreen extends StatefulWidget {
  const ActiveTaskScreen({super.key});

  @override
  State<ActiveTaskScreen> createState() => _ActiveTaskScreenState();
}

class _ActiveTaskScreenState extends State<ActiveTaskScreen> {
  double _enjoymentValue = 0.7;
  double _purposeValue = 0.5;
  
  bool _isPlaying = false;
  bool _isProgressDisabled = false;
  final int _totalDurationSeconds = 3600;
  int _remainingSeconds = 1902;
  Timer? _timer;
  
  bool _isDistractionActive = false;
  DateTime? _distractionStartTime;
  int _distractionElapsedSeconds = 0;
  Timer? _distractionTimer;
  final List<DistractionEntry> _distractions = [];

  @override
  void dispose() {
    _timer?.cancel();
    _distractionTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} h';
  }

  String _formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('MMMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    return '${dateFormat.format(dateTime)}; ${timeFormat.format(dateTime)}';
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      _isProgressDisabled = false;
      
      if (_isPlaying) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (_remainingSeconds > 0) {
              _remainingSeconds--;
            } else {
              _isPlaying = false;
              _timer?.cancel();
            }
          });
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _stopTask() {
    if (_isPlaying) return;
    
    setState(() {
      _isPlaying = false;
      _isProgressDisabled = true;
      _timer?.cancel();
    });
  }

  void _toggleDistraction() {
    setState(() {
      _isDistractionActive = !_isDistractionActive;
      
      if (_isDistractionActive) {
        _distractionStartTime = DateTime.now();
        _distractionElapsedSeconds = 0;
        _distractionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _distractionElapsedSeconds++;
          });
        });
      } else {
        _distractionTimer?.cancel();
        if (_distractionStartTime != null) {
          final distractionCount = _distractions.length + 1;
          _distractions.add(DistractionEntry(
            title: 'Distraction Task $distractionCount',
            duration: _formatDuration(_distractionElapsedSeconds),
            dateTime: _formatDateTime(_distractionStartTime!),
          ));
        }
        _distractionElapsedSeconds = 0;
        _distractionStartTime = null;
      }
    });
  }

  double get _progress {
    if (_totalDurationSeconds == 0) return 0.0;
    return _remainingSeconds / _totalDurationSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                AppHeader(
                  title: 'Active Task',
                  trailing: [
                    StatusBadge(
                      label: 'Focus',
                      icon: Icons.adjust,
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF8E8E93),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.question_mark, color: Colors.white, size: 10.sp),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    if (_isProgressDisabled) {
                      setState(() {
                        _isProgressDisabled = false;
                      });
                    }
                  },
                  child: Text(
                    'Task Name',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titleTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                const TaskMetadataRow(
                  startTime: '07:35 AM',
                  duration: '01:00 h',
                ),
                SizedBox(height: 0.h),
                CircularTimer(
                  progress: _progress,
                  timeRemaining: _formatTime(_remainingSeconds),
                  leftSliderValue: _enjoymentValue,
                  rightSliderValue: _purposeValue,
                  leftSliderLabel: 'Enjoyment',
                  rightSliderLabel: 'Purpose',
                  slidersEnabled: !_isProgressDisabled,
                  disabled: _isProgressDisabled,
                  onLeftSliderChanged: (value) {
                    if (!_isProgressDisabled) {
                      setState(() {
                        _enjoymentValue = value;
                      });
                    }
                  },
                  onRightSliderChanged: (value) {
                    if (!_isProgressDisabled) {
                      setState(() {
                        _purposeValue = value;
                      });
                    }
                  },
                ),
                SizedBox(height: 0.h),
                ActionButtonsRow(
                  onAddTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const AddMenuBottomSheet(),
                    );
                  },
                ),

                SizedBox(height: 30.h),
                Text(
                  'Distractions',
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBody,
                  ),
                ),
                SizedBox(height: 16.h),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 140.h),
                    itemCount: _distractions.length,
                    itemBuilder: (context, index) {
                      final distraction = _distractions[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: DistractionTaskCard(
                          title: distraction.title.isEmpty ? 'Distraction' : distraction.title,
                          duration: distraction.duration,
                          dateTime: distraction.dateTime,
                          isOpen: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomActionBar(
              isPlaying: _isPlaying,
              isDistractionActive: _isDistractionActive,
              distractionElapsedTime: _formatTime(_distractionElapsedSeconds),
              onStopTap: _stopTask,
              onDistractionTap: _toggleDistraction,
            ),
          ),

          if (_isPlaying)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),

          Positioned(
            left: 0,
            right: 0,
            bottom: AppDimensions.bottomBarPaddingVertical + 10.h, 
            child: Center(
              child: CircleIconButton(
                icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                size: AppDimensions.circleButtonSizeLarge,
                iconSize: 28.sp,
                iconColor: Colors.white,
                onTap: _togglePlayPause,
                gradient: const LinearGradient(
                  colors: [
                    AppColors.playButtonGradientStart,
                    AppColors.playButtonGradientEnd
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  !_isPlaying ? BoxShadow(
                    color: AppColors.playButtonShadow,
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ) : BoxShadow()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}