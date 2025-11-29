import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
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
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.dividerHorizontalPadding),
              child: Text(
                'or continue with',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: AppDimensions.spacing24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SocialButton(
                text: 'Login with Google',
                icon: Icons.g_mobiledata,
                iconColor: AppColors.iconRed,
                onPressed: () {},
              ),
            ),
            SizedBox(width: AppDimensions.gridSpacing16),
            Expanded(
              child: SocialButton(
                text: 'Login with Apple',
                icon: Icons.apple,
                iconColor: AppColors.iconBlack,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
