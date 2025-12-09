import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_assignment/features/auth/screens/create_account_screen.dart';
import 'package:tea_assignment/features/auth/screens/login_screen.dart';
import 'package:tea_assignment/shared/widgets/social_buttons_row.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgrounds/welcome.png'),
                  fit: BoxFit.fill,
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
                    Colors.black.withValues(alpha: 0.05),
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(),

                  Image.asset(
                    'assets/images/icons/tea_logo.png',
                    width: 100.w,
                    height: 100.h,
                  ),
                  SizedBox(height: 24.h),

                  Text(
                    'Welcome To TĒA',
                    style: GoogleFonts.outfit(
                      fontSize: 36.sp,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 60.h),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: GoogleFonts.outfit(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        Center(
                          child: CustomButton(
                            text: 'Login',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
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
                            borderWidth: 0.1,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        Center(
                          child: CustomButton(
                            text: 'Create Account',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateAccountScreen(),
                                ),
                              );
                            },
                            width: AppDimensions.buttonWidth,
                            height: AppDimensions.buttonHeight,
                            backgroundColor: AppColors.createAccountButtonColor,
                            textColor: AppColors.loginTextColor,
                            shadowColor: AppColors.createAccountButtonColor
                                .withValues(alpha: 0.4),
                            elevation: AppDimensions.buttonElevation,
                            borderRadius: AppDimensions.buttonBorderRadius,
                            hasBorder: true,
                            borderColor: Colors.black,
                            borderWidth: AppDimensions.buttonBorderWidth,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        const SocialButtonsRow(),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
