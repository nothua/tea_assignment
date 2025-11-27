import 'package:flutter/material.dart';
import 'package:tea_assignment/features/auth/screens/login_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/age_screen.dart';
import 'package:tea_assignment/features/onboarding/screens/success_screen.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';
import 'package:tea_assignment/shared/widgets/custom_text_field.dart';
import 'package:tea_assignment/shared/widgets/social_button.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Let\'s begin mindful progress.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  const CustomTextField(
                    label: 'Full Name',
                    hint: 'Enter your Full Name',
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: 'Email',
                    hint: 'Enter your Email',
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: 'Password',
                    hint: 'Enter your Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: 'Confirm Password',
                    hint: 'Re-enter your Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or continue with',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
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
                      const SizedBox(width: 16),
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
              const SizedBox(height: 24),
              
              Column(
                children: [
                  CustomButton(
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
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
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
    );
  }
}
