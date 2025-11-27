import 'package:flutter/material.dart';
import 'package:tea_assignment/shared/widgets/social_button.dart';

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              text: 'Login with Google',
              icon: Icons.g_mobiledata,
              iconColor: Colors.red,
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            SocialButton(
              text: 'Login with Apple',
              icon: Icons.apple,
              iconColor: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
