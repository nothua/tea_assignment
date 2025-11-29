import 'package:flutter/material.dart';
import 'package:tea_assignment/features/auth/screens/login_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/age_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/success_screen.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';
import 'package:tea_assignment/shared/widgets/custom_text_field.dart';
import 'package:tea_assignment/shared/widgets/social_button.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: null,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'assets/images/icons/back.png',
                          width: AppDimensions.backButtonWidth,
                          height: AppDimensions.backButtonHeight,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 32.h),
                        Text(
                          'Create Account',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: AppDimensions.titleFontSize,
                            fontWeight: FontWeight.w500,
                            color: AppColors.titleTextColor,
                          ),
                        ),
                        Text(
                          'Let\'s begin mindful progress.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            fontSize: AppDimensions.authSubtitleFontSize,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subtitleTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                
                Column(
                  children: [
                    const CustomTextField(
                      label: 'Full Name',
                      hint: 'Enter your Full Name',
                    ),
                    SizedBox(height: 20.h),
                    const CustomTextField(
                      label: 'Email',
                      hint: 'Enter your Email',
                    ),
                    SizedBox(height: 20.h),
                    const CustomTextField(
                      label: 'Password',
                      hint: 'Enter your Password',
                      isPassword: true,
                    ),
                    SizedBox(height: 20.h),
                    const CustomTextField(
                      label: 'Confirm Password',
                      hint: 'Re-enter your Password',
                      isPassword: true,
                    ),
                    SizedBox(height: 24.h),
                    
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'or continue with',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 12.sp
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    
                    Row(
                      children: [
                        Expanded(
                          child: SocialButton(
                            text: 'Login with Google',
                            icon: Icons.g_mobiledata, 
                            iconColor: Colors.red,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: SocialButton(
                            text: 'Login with Apple',
                            icon: Icons.apple,
                            iconColor: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                
                Column(
                  children: [
                    Center(
                      child: CustomButton(
                        text: 'Create Account',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuccessScreen(
                                nextScreen: AgeScreen(),
                                title: 'We are glad that you\nare here.',
                                subtitle: 'Get ready to fall in love with your life',
                              ),
                            ),
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
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.outfit(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.loginTextColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.outfit(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.loginTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}