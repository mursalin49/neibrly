import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';

enum RequestFilter { open, closed }

class RequestFilterTabs extends StatelessWidget {
  final RequestFilter currentFilter;
  final Function(RequestFilter) onFilterChanged;
  final int openCount;
  final int closedCount;

  const RequestFilterTabs({
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
              onTap: () => onFilterChanged(RequestFilter.open),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: currentFilter == RequestFilter.open 
                          ? Colors.black 
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      'Open',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: currentFilter == RequestFilter.open 
                          ? Colors.black 
                          : AppColors.DarkGray,
                    ),
                    if (currentFilter == RequestFilter.open) ...[
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
              onTap: () => onFilterChanged(RequestFilter.closed),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: currentFilter == RequestFilter.closed 
                          ? Colors.black 
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      'Closed',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: currentFilter == RequestFilter.closed 
                          ? Colors.black 
                          : AppColors.DarkGray,
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
