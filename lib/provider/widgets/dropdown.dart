import 'package:flutter/material.dart';
import 'colors.dart';


class KoreDropdown extends StatelessWidget {
  final String? label;

 final String hint ;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;

  const KoreDropdown({
    this.label,

    required this.items,
     required this.hint,
    this.selectedItem,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: selectedItem,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: KoreColors.border),
            ),
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
