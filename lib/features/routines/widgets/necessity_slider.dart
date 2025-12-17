import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NecessitySlider extends StatefulWidget {
  const NecessitySlider({super.key});

  @override
  State<NecessitySlider> createState() => _NecessitySliderState();
}

class _NecessitySliderState extends State<NecessitySlider> {
  double _necessityValue = 0.5;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  String get _currentLabel {
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

  void _showSliderOverlay() {
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
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
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
                          activeTrackColor: const Color(
                            0xFFFF6F42,
                          ), // Using consistent orange/alert color? Or should it be purple? Let's use purple for Necessity as it's a core metric. Or maybe red/orange for importance. Let's stick to the Enjoyment color scheme for now as a base or pick a new one. Let's use the Primary Purple for Necessity.
                          inactiveTrackColor: const Color(0xFFF3F0FF),
                          thumbColor: const Color(0xFF7F56D9),
                          trackHeight: 4.h,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 8.r,
                          ),
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 16.r,
                          ),
                        ),
                        child: Slider(
                          value: _necessityValue,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (val) {
                            setStateOverlay(() {
                              _necessityValue = val;
                            });
                            this.setState(() {
                              _necessityValue = val;
                            });
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
    return Column(
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
          link: _layerLink,
          child: GestureDetector(
            onTap: _showSliderOverlay,
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
                        color: const Color(0xFFF3F0FF), // Light Purple
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                      child: Text(
                        _currentLabel,
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          color: const Color(0xFF7F56D9), // Primary Purple
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      "assets/images/icons/system_icons.svg",
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF8E8E93),
                        BlendMode.srcIn,
                      ),
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
