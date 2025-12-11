import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tea_assignment/shared/widgets/tag_chip.dart';
import 'package:tea_assignment/shared/widgets/icon_text_button.dart';

import 'package:flutter_svg/flutter_svg.dart';

class TagsInputRow extends StatelessWidget {
  final List<String> tags;
  final Function(String) onRemoveTag;
  final VoidCallback? onAddTag;

  const TagsInputRow({
    super.key,
    required this.tags,
    required this.onRemoveTag,
    this.onAddTag,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/images/icons/tag.svg",
          colorFilter: const ColorFilter.mode(
            Color(0xFF8E8E93),
            BlendMode.srcIn,
          ),
          width: 16.sp,
          height: 16.sp,
        ),
        SizedBox(width: 14.w),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tags.map((tag) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: TagChip(label: tag, onRemove: () => onRemoveTag(tag)),
                );
              }).toList(),
            ),
          ),
        ),

        SizedBox(width: 8.w),
        IconTextButton(
          icon: Icons.add,
          label: "Add",
          onTap: onAddTag,
          color: Colors.blue[600],
          iconSize: 16.sp,
          fontSize: 12.sp,
        ),
      ],
    );
  }
}
