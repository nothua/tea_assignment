import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoutineAttributesSliders extends StatefulWidget {
  const RoutineAttributesSliders({super.key});

  @override
  State<RoutineAttributesSliders> createState() =>
      _RoutineAttributesSlidersState();
}

class _RoutineAttributesSlidersState extends State<RoutineAttributesSliders> {
  double _purposeValue = 0.5;
  double _enjoymentValue = 0.5;
  double _necessityValue = 0.5;

  final LayerLink _purposeLayerLink = LayerLink();
  final LayerLink _enjoymentLayerLink = LayerLink();
  final LayerLink _necessityLayerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  String get _currentPurposeLabel {
    if (_purposeValue < 0.33) return "Duty";
    if (_purposeValue < 0.66) return "Passion";
    return "Excitement";
  }

  String get _currentEnjoymentLabel {
    if (_enjoymentValue < 0.33) return "Low";
    if (_enjoymentValue < 0.66) return "Medium";
    return "High";
  }

  String get _currentNecessityLabel {
    if (_necessityValue < 0.33) return "Low";
    if (_necessityValue < 0.66) return "Medium";
    return "High";
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showSliderOverlay({
    required LayerLink layerLink,
    required double value,
    required Color activeColor,
    required Color inactiveColor,
    required ValueChanged<double> onChanged,
    Alignment targetAnchor = Alignment.bottomLeft,
    Alignment followerAnchor = Alignment.topLeft,
  }) {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            width: 200.w,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              targetAnchor: targetAnchor,
              followerAnchor: followerAnchor,
              offset: Offset(0, 8.h),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  child: StatefulBuilder(
                    builder: (context, setStateOverlay) {
                      return SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: activeColor,
                          inactiveTrackColor: inactiveColor,
                          thumbColor: activeColor,
                          trackHeight: 4.h,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 8.r,
                          ),
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 16.r,
                          ),
                        ),
                        child: Slider(
                          value: value,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (val) {
                            setStateOverlay(() {
                              value = val;
                            });
                            onChanged(val);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Purpose
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Purpose",
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              CompositedTransformTarget(
                link: _purposeLayerLink,
                child: _sliderContainer(
                  label: _currentPurposeLabel,
                  bgColor: const Color(0xFFD6E4FF),
                  textColor: const Color(0xFF2B75FF),
                  onTap: () {
                    _showSliderOverlay(
                      layerLink: _purposeLayerLink,
                      value: _purposeValue,
                      activeColor: const Color(0xFF2B75FF),
                      inactiveColor: const Color(0xFFD6E4FF),
                      onChanged: (val) {
                        setState(() {
                          _purposeValue = val;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        // Enjoyment
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enjoyment",
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              CompositedTransformTarget(
                link: _enjoymentLayerLink,
                child: _sliderContainer(
                  label: _currentEnjoymentLabel,
                  bgColor: const Color(0xFFFFE0D6),
                  textColor: const Color(0xFFFF6F42),
                  onTap: () {
                    _showSliderOverlay(
                      layerLink: _enjoymentLayerLink,
                      value: _enjoymentValue,
                      activeColor: const Color(0xFFFF6F42),
                      inactiveColor: const Color(0xFFFFE0D6),
                      onChanged: (val) {
                        setState(() {
                          _enjoymentValue = val;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        // Necessity
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Necessity",
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              CompositedTransformTarget(
                link: _necessityLayerLink,
                child: _sliderContainer(
                  label: _currentNecessityLabel,
                  bgColor: const Color(0xFFF3F0FF),
                  textColor: const Color(0xFF7F56D9), // Primary Purple
                  onTap: () {
                    _showSliderOverlay(
                      layerLink: _necessityLayerLink,
                      value: _necessityValue,
                      activeColor: const Color(0xFF7F56D9),
                      inactiveColor: const Color(0xFFF3F0FF),
                      onChanged: (val) {
                        setState(() {
                          _necessityValue = val;
                        });
                      },
                      targetAnchor: Alignment.bottomRight,
                      followerAnchor: Alignment.topRight,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sliderContainer({
    required String label,
    required Color bgColor,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ), // Reduce padding to fit 3 cols
              child: SvgPicture.asset(
                "assets/images/icons/system_icons.svg",
                colorFilter: const ColorFilter.mode(
                  Color(0xFF8E8E93),
                  BlendMode.srcIn,
                ),
                width: 16.sp, // Slightly smaller icon
                height: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
