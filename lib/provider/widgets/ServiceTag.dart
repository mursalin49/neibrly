
import 'package:flutter/material.dart';

class ServiceTag extends StatelessWidget {
  final String text;
  final Color dotColor;
  final Color textColor;
  final Color backgroundColor;

  const ServiceTag({
    super.key,
    required this.text,
    required this.dotColor,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // full width like your screenshot
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Dot
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
            color: textColor,
          ),
          const SizedBox(width: 8),

          // Text (same color as dot)
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
