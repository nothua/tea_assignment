import 'package:flutter/material.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/shared/widgets/slider/no_padding_track_shape.dart';


class CustomSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final ValueChanged<double>? onChanged;
  final bool hideEdgeTicks;

  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.hideEdgeTicks = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.sliderHeight,
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: AppDimensions.sliderTrackHeight,
          activeTrackColor: AppColors.sliderActive,
          inactiveTrackColor: AppColors.sliderInactive,
          thumbColor: AppColors.sliderThumb,
          overlayColor: AppColors.sliderOverlay.withValues(
            alpha: AppDimensions.sliderOverlayOpacity,
          ),
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: AppDimensions.sliderThumbRadius,
          ),
          overlayShape: RoundSliderOverlayShape(
            overlayRadius: AppDimensions.sliderOverlayRadius,
          ),
          tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.white,
          trackShape: NoPaddingTrackShape(
            divisions: divisions,
            hideEdgeTicks: hideEdgeTicks,
          ),
        ),
        child: Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: label,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
