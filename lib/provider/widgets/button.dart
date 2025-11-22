import 'package:flutter/material.dart';
import 'colors.dart';


class KoreButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isCancel;
  const KoreButton({
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isCancel = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;
    double borderWidth;

    if (isCancel) {
      backgroundColor = const Color(0xFFFEEEEE);
      foregroundColor = const Color(0xFFF34F4F);
      borderColor = const Color(0xFFFCCBCB);
      borderWidth = 0.5;
    } else if (isPrimary) {
      backgroundColor = const Color(0xFF0E7A60);
      foregroundColor = Colors.white;
      borderColor = const Color(0xFF0E7A60);
      borderWidth = 0;
    } else {
      backgroundColor = Colors.white;
      foregroundColor = KoreColors.textDark;
      borderColor = KoreColors.border;
      borderWidth = 1;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderWidth > 0 
                ? BorderSide(color: borderColor, width: borderWidth)
                : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: foregroundColor)),
      ),
    );
  }
}
