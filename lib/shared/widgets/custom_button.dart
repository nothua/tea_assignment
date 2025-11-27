import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide.none,
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.1),
          ),
          child: Text(text),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: backgroundColor != null
            ? ElevatedButton.styleFrom(backgroundColor: backgroundColor)
            : null,
        child: Text(
          text,
          style: textColor != null ? TextStyle(color: textColor) : null,
        ),
      ),
    );
  }
}
