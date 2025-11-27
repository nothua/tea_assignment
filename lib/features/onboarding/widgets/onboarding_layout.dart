import 'package:flutter/material.dart';
import 'package:tea_assignment/shared/widgets/custom_button.dart';

class OnboardingLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback onContinue;
  final double progress;
  final String? backgroundImage;

  const OnboardingLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.onContinue,
    required this.progress,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: backgroundImage != null && backgroundImage!.startsWith('assets/')
                      ? AssetImage(backgroundImage!) as ImageProvider
                      : NetworkImage(
                          backgroundImage 
                        ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                    child: Column(
                      children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              const Spacer(),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Text',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    
                    child,
                    
                    const SizedBox(height: 30),
                    
                    CustomButton(
                      text: 'Continue',
                      onPressed: onContinue,
                    ),
                    const SizedBox(height: 16),
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
