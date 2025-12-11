import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TaskStatus {
  open,
  done,
  moved,
  closed,
  canceled,
  missed,
  duplicated,
  overdue,
}

class StatusSelector extends StatefulWidget {
  final TaskStatus initialStatus;
  final ValueChanged<TaskStatus> onStatusChanged;

  const StatusSelector({
    super.key,
    this.initialStatus = TaskStatus.open,
    required this.onStatusChanged,
  });

  @override
  State<StatusSelector> createState() => _StatusSelectorState();
}

class _StatusSelectorState extends State<StatusSelector> {
  late TaskStatus _currentStatus;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.initialStatus;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withValues(alpha: 0.1)),
              ),
            ),
          ),
          // Dropdown Menu
          Positioned(
            width: 180.w,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomRight,
              followerAnchor: Alignment.topRight,
              offset: Offset(0, 12.h),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: TaskStatus.values.map((status) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: _buildStatusPill(status),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  Widget _buildStatusPill(TaskStatus status) {
    final isSelected = _currentStatus == status;
    final color = _getStatusColor(status);
    final backgroundColor = _getStatusBackgroundColor(status);

    return GestureDetector(
      onTap: () {
        if (mounted) {
          setState(() {
            _currentStatus = status;
          });
        }
        widget.onStatusChanged(status);
        _removeOverlay();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  _getStatusLabel(status),
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            if (isSelected) Icon(Icons.check, color: color, size: 18.sp),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.open:
        return const Color(0xFFFF6F42); // Orange
      case TaskStatus.done:
        return const Color(0xFF4CD964); // Green
      case TaskStatus.moved:
        return Colors.grey;
      case TaskStatus.closed:
        return const Color(0xFFFF3B30); // Red
      case TaskStatus.canceled:
        return const Color(0xFFFF3B30); // Red
      case TaskStatus.missed:
        return const Color(0xFFFF3B30); // Red
      case TaskStatus.duplicated:
        return const Color(0xFF007AFF); // Blue
      case TaskStatus.overdue:
        return const Color(0xFFFFCC00); // Yellow
    }
  }

  Color _getStatusBackgroundColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.open:
        return const Color(0xFFFFF0EB);
      case TaskStatus.done:
        return const Color(0xFFE8FCEB);
      case TaskStatus.moved:
        return const Color(0xFFF2F2F7);
      case TaskStatus.closed:
        return const Color(0xFFFFEBEA);
      case TaskStatus.canceled:
        return const Color(0xFFFFEBEA);
      case TaskStatus.missed:
        return const Color(0xFFFFEBEA);
      case TaskStatus.duplicated:
        return const Color(0xFFE5F1FF);
      case TaskStatus.overdue:
        return const Color(0xFFFFFBE6);
    }
  }

  String _getStatusLabel(TaskStatus status) {
    switch (status) {
      case TaskStatus.open:
        return "Open";
      case TaskStatus.done:
        return "Done";
      case TaskStatus.moved:
        return "Moved";
      case TaskStatus.closed:
        return "Closed";
      case TaskStatus.canceled:
        return "Canceled";
      case TaskStatus.missed:
        return "Missed";
      case TaskStatus.duplicated:
        return "Duplicated";
      case TaskStatus.overdue:
        return "Overdue";
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(_currentStatus);
    final backgroundColor = _getStatusBackgroundColor(_currentStatus);

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              SizedBox(width: 6.w),
              Text(
                _getStatusLabel(_currentStatus),
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 16.sp,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
