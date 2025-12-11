import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionGridButtons extends StatelessWidget {
  final VoidCallback? onLocationTap;
  final VoidCallback? onCompaniesTap;
  final VoidCallback? onContactsTap;
  final VoidCallback? onAttachmentsTap;
  final VoidCallback? onLinksTap;
  final VoidCallback? onAssociatedTap;

  final bool isLocationSelected;
  final bool isCompaniesSelected;
  final bool isContactsSelected;
  final bool isAttachmentsSelected;
  final bool isLinksSelected;
  final bool isAssociatedSelected;

  const ActionGridButtons({
    super.key,
    this.onLocationTap,
    this.onCompaniesTap,
    this.onContactsTap,
    this.onAttachmentsTap,
    this.onLinksTap,
    this.onAssociatedTap,
    this.isLocationSelected = false,
    this.isCompaniesSelected = false,
    this.isContactsSelected = false,
    this.isAttachmentsSelected = false,
    this.isLinksSelected = false,
    this.isAssociatedSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _bottomBtn(
              "assets/images/icons/location.svg",
              "Location",
              isSelected: isLocationSelected,
              onTap: onLocationTap,
            ),
            _bottomBtn(
              "assets/images/icons/company.svg",
              "Companies",
              isSelected: isCompaniesSelected,
              onTap: onCompaniesTap,
            ),
            _bottomBtn(
              "assets/images/icons/document.svg",
              "Attachments",
              isSelected: isAttachmentsSelected,
              onTap: onAttachmentsTap,
            ),
            _bottomBtn(
              "assets/images/icons/link.svg",
              "Links",
              isSelected: isLinksSelected,
              onTap: onLinksTap,
            ),
            _bottomBtn(
              "assets/images/icons/task-square.svg",
              "Associated",
              isSelected: isAssociatedSelected,
              onTap: onAssociatedTap,
            ),
            _bottomBtn(
              null,
              "Contacts",
              iconData: Icons.person_outline,
              isSelected: isContactsSelected,
              onTap: onContactsTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomBtn(
    String? svgIcon,
    String label, {
    IconData? iconData,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    if (onTap == null) return const SizedBox.shrink();

    final bgColor = isSelected
        ? const Color(0xFFE0E0F6)
        : const Color(0xFFF7F7F8);
    final iconColor = isSelected
        ? const Color(0xFF5F5FBC)
        : const Color(0xFF8A8AB5);
    final textColor = isSelected
        ? const Color(0xFF5F5FBC)
        : const Color(0xFF8A8AB5);

    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 80.w,
          height: 75.h,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (svgIcon != null)
                      SvgPicture.asset(
                        svgIcon,
                        colorFilter: ColorFilter.mode(
                          iconColor,
                          BlendMode.srcIn,
                        ),
                        width: 22.sp,
                        height: 22.sp,
                      )
                    else if (iconData != null)
                      Icon(iconData, color: iconColor, size: 22.sp),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: isSelected
                    ? Icon(Icons.check, size: 12.sp, color: textColor)
                    : Icon(Icons.add, size: 12.sp, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
