import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';

class SuccessScreen extends StatelessWidget {
  final Widget? nextScreen;
  final String title;
  final String subtitle;
  final VoidCallback? onDismiss;

  const SuccessScreen({
    super.key,
    this.nextScreen,
    this.title = 'Welcome to TĒA',
    this.subtitle = 'A Better You Is Closer Than You Think',
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    if (nextScreen != null) {
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => nextScreen!),
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: GestureDetector(
        onTap: () {
          if (onDismiss != null) {
            onDismiss!();
          } else if (nextScreen != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => nextScreen!),
            );
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgrounds/success.png'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.headerHorizontalPadding,
                  vertical: 0.h,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: AppDimensions.titleFontSize,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.dmSans(
                          fontSize: AppDimensions.fontSize16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textGrey,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
