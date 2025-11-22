import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final VoidCallback onClose;

  const CustomDatePicker({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
    required this.onClose,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime currentMonth;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final initial = widget.selectedDate ?? today;
    selectedDate = initial.isBefore(today) ? today : initial;
    currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final firstAllowedMonth = DateTime(today.year, today.month, 1);
    if (currentMonth.isBefore(firstAllowedMonth)) {
      currentMonth = firstAllowedMonth;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildDaysOfWeek(),
              _buildCalendarGrid(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              final now = DateTime.now();
              final firstAllowedMonth = DateTime(now.year, now.month, 1);
              final prev = DateTime(currentMonth.year, currentMonth.month - 1, 1);
              if (prev.isBefore(firstAllowedMonth)) return;
              setState(() {
                currentMonth = prev;
              });
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.chevron_left,
                color: AppColors.textcolor,
                size: 20,
              ),
            ),
          ),
          Text(
            _getMonthYearText(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textcolor,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
              });
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.chevron_right,
                color: AppColors.textcolor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaysOfWeek() {
    final daysOfWeek = const ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: daysOfWeek
            .map((day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    final daysFromPrevMonth = firstWeekday - 1;
    const totalCells = 42;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: totalCells,
        itemBuilder: (context, index) {
          if (index < daysFromPrevMonth) {
            return const SizedBox();
          } else if (index < daysFromPrevMonth + daysInMonth) {
            final day = index - daysFromPrevMonth + 1;
            final date = DateTime(currentMonth.year, currentMonth.month, day);
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);
            final isDisabled = date.isBefore(today);
            final isSelected = selectedDate.year == date.year &&
                selectedDate.month == date.month &&
                selectedDate.day == date.day;

            return GestureDetector(
              onTap: isDisabled
                  ? null
                  : () {
                      setState(() {
                        selectedDate = date;
                      });
                      widget.onDateSelected(date);
                      widget.onClose();
                    },
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? Colors.white
                          : (isDisabled ? Colors.grey : AppColors.textcolor),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  String _getMonthYearText() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[currentMonth.month - 1]} ${currentMonth.year}';
  }
}


