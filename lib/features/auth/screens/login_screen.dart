import 'package:flutter/material.dart';
import 'package:tea_assignment/features/auth/screens/create_account_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/age_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/success_screen.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';
import 'package:tea_assignment/shared/widgets/custom_text_field.dart';
import 'package:tea_assignment/shared/widgets/social_buttons_row.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

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
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.headerHorizontalPadding,
              vertical: 0.h,
            ),
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
                        SizedBox(height: AppDimensions.spacing32),
                        Text(
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: AppDimensions.titleFontSize,
                            fontWeight: FontWeight.w500,
                            color: AppColors.titleTextColor,
                          ),
                        ),
                        Text(
                          'Let\'s make today meaningful.',
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
                SizedBox(height: AppDimensions.spacing40),
                Column(
                  children: [
                    const CustomTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                    ),
                    SizedBox(height: AppDimensions.spacing20),
                    const CustomTextField(
                      label: 'Password',
                      hint: 'Enter your Password',
                      isPassword: true,
                    ),
                    SizedBox(height: AppDimensions.spacing16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: AppDimensions.checkboxSize,
                              width: AppDimensions.checkboxSize,
                              child: Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                                shape: const CircleBorder(),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: AppDimensions.borderWidth1_5,
                                ),
                                activeColor: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(width: AppDimensions.spacing8),
                            Text(
                              'Remember Me',
                              style: GoogleFonts.dmSans(
                                fontSize: AppDimensions.fontSize12,
                                color: AppColors.subtitleTextColor,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'Forgot your Password?',
                              style: GoogleFonts.dmSans(
                                fontSize: AppDimensions.fontSize12,
                                color: AppColors.subtitleTextColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spacing30),
                    const SocialButtonsRow(),
                  ],
                ),
                SizedBox(height: AppDimensions.spacing65),
                Column(
                  children: [
                    Center(
                      child: CustomButton(
                        text: 'Login',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuccessScreen(
                                nextScreen: AgeScreen(),
                                title: 'We are glad that you\nare here.',
                                subtitle:
                                    'Get ready to fall in love with your life',
                              ),
                            ),
                          );
                        },
                        width: AppDimensions.buttonWidth,
                        height: AppDimensions.buttonHeight,
                        backgroundColor: AppColors.loginButtonColor,
                        textColor: AppColors.whiteColor,
                        shadowColor: AppColors.loginButtonColor.withValues(
                          alpha: 0.4,
                        ),
                        elevation: AppDimensions.buttonElevation,
                        borderRadius: AppDimensions.buttonBorderRadius,
                        hasBorder: true,
                        borderColor: AppColors.borderBlack,
                        borderWidth: AppDimensions.buttonBorderWidth,
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacing16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account? ",
                          style: GoogleFonts.outfit(
                            fontSize: AppDimensions.buttonFontSize,
                            fontWeight: FontWeight.w500,
                            color: AppColors.loginTextColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateAccountScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.outfit(
                              fontSize: AppDimensions.buttonFontSize,
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
