import 'package:flutter/material.dart';
import '../../viewmodels/orders_viewmodel.dart';
import '../colors.dart';

class FilterTabs extends StatelessWidget {
  final OrderFilter currentFilter;
  final Function(OrderFilter) onFilterChanged;
  final int openCount;
  final int closedCount;

  const FilterTabs({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    required this.openCount,
    required this.closedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Open tab
          Expanded(
            child: GestureDetector(
              onTap: () => onFilterChanged(OrderFilter.open),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: currentFilter == OrderFilter.open 
                          ? Colors.black 
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Open',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: currentFilter == OrderFilter.open 
                            ? Colors.black 
                            : KoreColors.textLight,
                      ),
                    ),
                    if (currentFilter == OrderFilter.open) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          
          // Closed tab
          Expanded(
            child: GestureDetector(
              onTap: () => onFilterChanged(OrderFilter.closed),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: currentFilter == OrderFilter.closed 
                          ? Colors.black 
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Closed',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: currentFilter == OrderFilter.closed 
                            ? Colors.black 
                            : KoreColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
