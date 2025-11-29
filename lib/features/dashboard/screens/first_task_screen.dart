import 'package:flutter/material.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstTaskScreen extends StatefulWidget {
  const FirstTaskScreen({super.key});

  @override
  State<FirstTaskScreen> createState() => _FirstTaskScreenState();
}

class _FirstTaskScreenState extends State<FirstTaskScreen> {
  String? _selectedTask;
  String _selectedDay = 'Today';
  TimeOfDay _startTime = const TimeOfDay(hour: 0, minute: 0);
  Duration _duration = const Duration(hours: 0, minutes: 0);

  final List<String> _tasks = ['Exercise', 'Meditate', 'Plan Meals', 'Read', 'Organize Workspace'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/illustrations/clarity_starts_here.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          // Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          
          Positioned.fill(
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimensions.headerHorizontalPadding, vertical: AppDimensions.headerVerticalPadding),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Image.asset(
                              'assets/images/icons/back_white.png',
                              width: AppDimensions.backButtonWidth,
                              height: AppDimensions.backButtonHeight,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Clarity Starts Here',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: AppDimensions.titleFontSize,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const Spacer(),
                
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppDimensions.cardPadding),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.gradientStart,
                        AppColors.gradientEnd,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppDimensions.spacing25),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Start Your First Action',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: AppDimensions.subtitleFontSize,
                                fontWeight: FontWeight.w500,
                                color: AppColors.subtitleTextColor,
                              ),
                            ),
                            SizedBox(height: AppDimensions.spacing5),
                            Text(
                              'Choose One Thing you\'d like to complete today',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                fontSize: AppDimensions.bodyFontSize,
                                color: AppColors.subtitleTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing20),
                      
                      const Text('What\'s one task you want to complete today?', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _tasks.map((task) {
                          final isSelected = _selectedTask == task;
                          return ChoiceChip(
                            label: Text(task),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedTask = selected ? task : null;
                              });
                            },
                            selectedColor: Colors.white,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.black : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected ? Colors.black : Colors.grey.shade300,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            showCheckmark: false,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      
                      const Text('When would you like to do this?', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildDayButton('Today')),
                          const SizedBox(width: 16),
                          Expanded(child: _buildDayButton('Tomorrow')),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      _buildTimeRow('Select Start Time', '00:00 AM'),
                      const SizedBox(height: 16),
                      _buildTimeRow('Estimated Duration', '00:00'),
                      
                      SizedBox(height: AppDimensions.spacing35),
                      
                      Center(
                        child: CustomButton(
                          text: 'Continue',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Setup Complete!')),
                            );
                          },
                          width: AppDimensions.buttonWidth,
                          height: AppDimensions.buttonHeight,
                          backgroundColor: AppColors.loginButtonColor,
                          textColor: Colors.white,
                          shadowColor: AppColors.loginButtonColor.withOpacity(0.4),
                          elevation: AppDimensions.buttonElevation,
                          borderRadius: AppDimensions.buttonBorderRadius,
                          hasBorder: true,
                          borderColor: Colors.black,
                          borderWidth: AppDimensions.buttonBorderWidth,
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing65),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton(String day) {
    final isSelected = _selectedDay == day;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDay = day;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3F0FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey.shade600),
            ],
          ),
        ),
      ],
    );
  }
}
