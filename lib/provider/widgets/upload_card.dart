import 'package:flutter/material.dart';
import 'colors.dart';


class KoreUploadCard extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;

  const KoreUploadCard({
    required this.label,
    required this.hint,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 217,
      width: 353,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: KoreColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: KoreColors.textLight, size: 36),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          Text(hint, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: KoreColors.textLight)),
        ],
      ),
    );
  }
}
