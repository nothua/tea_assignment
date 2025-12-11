import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/features/add_task/widgets/simple_input_row.dart';

class CommonActionRows extends StatelessWidget {
  final bool showLocation;
  final bool showCompanies;
  final bool showAttachments;
  final bool showLinks;
  final bool showAssociated;
  final bool showContacts;

  final VoidCallback? onLocationTap;
  final VoidCallback? onCompaniesTap;
  final VoidCallback? onAttachmentsTap;
  final VoidCallback? onLinksTap;
  final VoidCallback? onAssociatedTap;
  final VoidCallback? onContactsTap;

  const CommonActionRows({
    super.key,
    this.showLocation = false,
    this.showCompanies = false,
    this.showAttachments = false,
    this.showLinks = false,
    this.showAssociated = false,
    this.showContacts = false,
    this.onLocationTap,
    this.onCompaniesTap,
    this.onAttachmentsTap,
    this.onLinksTap,
    this.onAssociatedTap,
    this.onContactsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showLocation) ...[
          SimpleInputRow(
            svgIcon: "assets/images/icons/location.svg",
            hint: "Location",
            actionLabel: "Map",
            actionIcon: Icons.map_outlined,
            onActionTap: onLocationTap ?? () {},
            iconSize: 16,
          ),
          SizedBox(height: 24.h),
          const Divider(height: 1),
          SizedBox(height: 24.h),
        ],
        if (showCompanies) ...[
          SimpleInputRow(
            svgIcon: "assets/images/icons/company.svg",
            hint: "Companies",
            actionLabel: "Add",
            actionIcon: Icons.add,
            onActionTap: onCompaniesTap ?? () {},
            iconSize: 16,
          ),
          SizedBox(height: 24.h),
          const Divider(height: 1),
          SizedBox(height: 24.h),
        ],
        if (showAttachments) ...[
          SimpleInputRow(
            svgIcon: "assets/images/icons/document.svg",
            hint: "Attachments",
            actionLabel: "Add",
            actionIcon: Icons.add,
            onActionTap: onAttachmentsTap ?? () {},
            iconSize: 16,
          ),
          SizedBox(height: 24.h),
          const Divider(height: 1),
          SizedBox(height: 24.h),
        ],
        if (showLinks) ...[
          SimpleInputRow(
            svgIcon: "assets/images/icons/link.svg",
            hint: "Links",
            actionLabel: "Add",
            actionIcon: Icons.add,
            onActionTap: onLinksTap ?? () {},
            iconSize: 16,
          ),
          SizedBox(height: 24.h),
          const Divider(height: 1),
          SizedBox(height: 24.h),
        ],
        if (showAssociated) ...[
          SimpleInputRow(
            svgIcon: "assets/images/icons/task-square.svg",
            hint: "Associated",
            actionLabel: "Add",
            actionIcon: Icons.add,
            onActionTap: onAssociatedTap ?? () {},
            iconSize: 16,
          ),
          SizedBox(height: 24.h),
          const Divider(height: 1),
          SizedBox(height: 24.h),
        ],
        if (showContacts) ...[
          SimpleInputRow(
            icon: Icons.person_outline,
            hint: "Contacts",
            actionLabel: "Add",
            actionIcon: Icons.add,
            onActionTap: onContactsTap ?? () {},
            iconSize: 16,
          ),
          SizedBox(height: 24.h),
          const Divider(height: 1),
          SizedBox(height: 24.h),
        ],
      ],
    );
  }
}
