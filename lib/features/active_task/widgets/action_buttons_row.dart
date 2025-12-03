import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/shared/widgets/circle_icon_button.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback? onAddTap;
  final VoidCallback? onPersonTap;
  final VoidCallback? onFlowTap;
  final VoidCallback? onMoreTap;

  const ActionButtonsRow({
    super.key,
    this.onAddTap,
    this.onPersonTap,
    this.onFlowTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleIconButton(
          icon: Icons.add,
          onTap: onAddTap,
          size: AppDimensions.circleButtonSizeMedium,
        ),
        SizedBox(width: 16.w),
        CircleIconButton(
          icon: Icons.person_outline,
          onTap: onPersonTap,
          size: AppDimensions.circleButtonSizeMedium,
        ),
        SizedBox(width: 16.w),
        CircleIconButton(
          icon: Icons.alt_route,
          onTap: onFlowTap,
          size: AppDimensions.circleButtonSizeMedium,
        ),
        SizedBox(width: 16.w),
        CircleIconButton(
          icon: Icons.more_horiz,
          onTap: onMoreTap,
          size: AppDimensions.circleButtonSizeMedium,
        ),
      ],
    );
  }
}
