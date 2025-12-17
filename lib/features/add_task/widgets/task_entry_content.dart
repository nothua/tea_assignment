import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/features/add_task/widgets/voice_entry_bottom_bar.dart';
import 'package:tea_assignment/shared/widgets/app_header.dart';

class TaskEntryContent extends StatelessWidget {
  final String title;
  final VoidCallback onClose;
  final Widget child;
  final VoidCallback? onCheck;
  final VoidCallback? onVoiceEntry;
  final Widget? leading;
  final List<Widget>? trailing;
  final bool showHeader;
  final bool showVoiceButton;

  const TaskEntryContent({
    super.key,
    required this.title,
    required this.onClose,
    required this.child,
    this.onCheck,
    this.onVoiceEntry,
    this.leading,
    this.trailing,
    this.showHeader = true,
    this.showVoiceButton = true,
    this.showBackButton = true,
  });

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showHeader)
          Container(
            color: Colors.white,
            child: AppHeader(
              title: title,
              showBackButton: showBackButton,
              onBackPressed: onClose,
              trailing:
                  trailing ??
                  [
                    IconButton(
                      icon: Image.asset(
                        "assets/images/icons/element-plus.png",
                        width: 24.w,
                        height: 24.w,
                      ),
                      onPressed: () {},
                    ),
                  ],
            ),
          ),
        Expanded(child: child),
        VoiceEntryBottomBar(
          onClose: onClose,
          onCheck: onCheck ?? () {},
          onVoiceEntry: onVoiceEntry ?? () {},
          showVoiceButton: showVoiceButton,
        ),
      ],
    );
  }
}
