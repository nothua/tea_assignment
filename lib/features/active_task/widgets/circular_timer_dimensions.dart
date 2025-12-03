import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularTimerDimensions {
  final double size;

  CircularTimerDimensions(this.size);

  static const double _progressRadiusRatio = 131.4 / 180.0;
  static const double _sliderBgRadiusRatio = 136.0 / 180.0;
  static const double _innerRadiusRatio = 104.0 / 180.0;
  static const double _strokeWidthRatio = 16.0 / 360.0;
  static const double _sliderArcOffsetRatio = 22.5 / 180.0;
  static const double _leftSliderExtraOffsetRatio = 1.8 / 180.0;
  static const double _textOffsetRatio = 11.0 / 180.0;

  double get width => size.w;
  double get height => size.w;
  double get center => size.w / 2;
  
  double get strokeWidth => size.w * _strokeWidthRatio;
  
  double get progressRadius => (size.w / 2) * _progressRadiusRatio;
  
  double get sliderBgRadius => (size.w / 2) * _sliderBgRadiusRatio;
  
  double get innerCircleRadius => (size.w / 2) * _innerRadiusRatio;
  
  double get rightSliderRadius => sliderBgRadius + ((size.w / 2) * _sliderArcOffsetRatio);
  
  double get leftSliderRadius => rightSliderRadius + ((size.w / 2) * _leftSliderExtraOffsetRatio);
  
  double get textOffset => (size.w / 2) * _textOffsetRatio;
}
