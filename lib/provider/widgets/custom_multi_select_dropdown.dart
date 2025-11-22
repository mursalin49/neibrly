import 'package:flutter/material.dart';
import 'colors.dart';

class CustomMultiSelectDropdown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onChanged;

  const CustomMultiSelectDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
  });

  @override
  State<CustomMultiSelectDropdown> createState() => _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: widget.selectedItems.isEmpty
                      ? Text(
                          widget.hint,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        )
                      : Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            // Show up to 2 items
                            ...widget.selectedItems.take(2).map((item) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: KoreColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1C1C1C),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    InkWell(
                                      onTap: () {
                                        final newSelected = List<String>.from(widget.selectedItems);
                                        newSelected.remove(item);
                                        widget.onChanged(newSelected);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: KoreColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            // Show count if more than 2 items selected
                            if (widget.selectedItems.length > 2)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: KoreColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "+${widget.selectedItems.length - 2} more",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: widget.items.map((item) {
                final isSelected = widget.selectedItems.contains(item);
                return InkWell(
                  onTap: () {
                    final newSelected = List<String>.from(widget.selectedItems);
                    if (isSelected) {
                      newSelected.remove(item);
                    } else {
                      newSelected.add(item);
                    }
                    widget.onChanged(newSelected);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? KoreColors.primary : const Color(0xFF1C1C1C),
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: KoreColors.primary,
                          )
                        else
                          Icon(
                            Icons.circle_outlined,
                            size: 20,
                            color: Colors.grey.shade400,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

