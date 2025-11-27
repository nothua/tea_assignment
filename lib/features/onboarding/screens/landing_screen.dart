import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tea_assignment/core/theme/app_theme.dart';
import 'package:tea_assignment/features/onboarding/screens/welcome_screen.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgrounds/get_started.png'),
                  fit: BoxFit.cover,
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
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.6),
                    const Color(0xFF2E2E3E), 
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                  const Spacer(),
                  
                  Text(
                    'Turn everyday noise\ninto productivity.',
                    style: GoogleFonts.outfit(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(
                    'Discover how to transform your thoughts, emotions, and actions into focused progress',
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  Center(
                    child: SizedBox(
                      height: 48,
                      width: 308,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: const Text('Get Started'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
