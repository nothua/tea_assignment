import 'package:flutter/material.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final String text;
  final Widget child;
  final VoidCallback onContinue;
  final double progress;
  final String? backgroundImage;
  final String buttonText;

  const OnboardingLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.onContinue,
    required this.progress,
    this.text = "",
    this.buttonText = "Continue",
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      backgroundImage != null &&
                          backgroundImage!.startsWith('assets/')
                      ? AssetImage(backgroundImage!) as ImageProvider
                      : NetworkImage(backgroundImage ?? ""),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.1),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.headerHorizontalPadding,
                      vertical: AppDimensions.headerVerticalPadding,
                    ),
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
                              title,
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
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: AppDimensions.spacing25),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.progressColor,
                          ),
                          minHeight: 6,
                        ),
                      ),
                      SizedBox(height: 35.h),

                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: AppDimensions.subtitleFontSize,
                          fontWeight: FontWeight.w500,
                          color: AppColors.subtitleTextColor,
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing5),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: AppDimensions.bodyFontSize,
                          color: AppColors.subtitleTextColor,
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing20),
                      child,

                      SizedBox(height: AppDimensions.spacing35),

                      Center(
                        child: CustomButton(
                          text: buttonText,
                          onPressed: onContinue,
                          width: AppDimensions.buttonWidth,
                          height: AppDimensions.buttonHeight,
                          backgroundColor: AppColors.loginButtonColor,
                          textColor: Colors.white,
                          shadowColor: AppColors.loginButtonColor.withValues(
                            alpha: 0.4,
                          ),
                          elevation: AppDimensions.buttonElevation,
                          borderRadius: AppDimensions.buttonBorderRadius,
                          hasBorder: true,
                          borderColor: Colors.black,
                          borderWidth: AppDimensions.buttonBorderWidth,
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing16),
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
}
