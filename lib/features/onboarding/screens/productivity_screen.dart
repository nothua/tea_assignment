import 'package:flutter/material.dart';
import 'package:tea_assignment/features/onboarding/widgets/onboarding_layout.dart';
import 'package:tea_assignment/features/onboarding/screens/energy_screen.dart';

class ProductivityScreen extends StatefulWidget {
  const ProductivityScreen({super.key});

  @override
  State<ProductivityScreen> createState() => _ProductivityScreenState();
}

class _ProductivityScreenState extends State<ProductivityScreen> {
  String? _selectedTime;
  final List<Map<String, String>> _times = [
    {'title': 'Morning Person', 'time': '5AM - 11AM', 'image': 'assets/images/illustrations/morning.png'},
    {'title': 'Afternoon Focus', 'time': '11AM - 5PM', 'image': 'assets/images/illustrations/afternoon.png'},
    {'title': 'Evening Burst', 'time': '5PM - 10PM', 'image': 'assets/images/illustrations/evening.png'},
    {'title': 'Night Owl', 'time': '10PM - 4AM', 'image': 'assets/images/illustrations/night.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: 'Productivity',
      subtitle: 'When do you feel most productive?',
      text: "Choose the time when you feel the most focus.",
      progress: 0.45,
      backgroundImage: 'assets/images/illustrations/productivity.png',
      onContinue: () {
        if (_selectedTime != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EnergyScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a time')),
          );
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount: _times.length,
            itemBuilder: (context, index) {
              final item = _times[index];
              final isSelected = _selectedTime == item['title'];
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedTime = item['title'];
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                       image: AssetImage(item['image']!),
                       fit: BoxFit.cover,
                       opacity: 0.6,
                    ),
                    border: isSelected ? Border.all(color: Theme.of(context).primaryColor, width: 3) : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['time']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
