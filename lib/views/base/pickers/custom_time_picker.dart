import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;
  final VoidCallback onClose;

  const CustomTimePicker({
    super.key,
    this.selectedTime,
    required this.onTimeSelected,
    required this.onClose,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _periodController;

  late int selectedHour; // 1-12
  late int selectedMinute; // 0-59
  late bool isPM;

  @override
  void initState() {
    super.initState();
    final initialTime = widget.selectedTime ?? TimeOfDay.now();
    final hour12 = initialTime.hourOfPeriod == 0 ? 12 : initialTime.hourOfPeriod;
    selectedHour = hour12;
    selectedMinute = initialTime.minute;
    isPM = initialTime.period == DayPeriod.pm;

    _hourController = FixedExtentScrollController(initialItem: selectedHour - 1);
    _minuteController = FixedExtentScrollController(initialItem: selectedMinute);
    _periodController = FixedExtentScrollController(initialItem: isPM ? 1 : 0);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Text(
                      'Set time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textcolor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildTimePicker(),
                const SizedBox(height: 24),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: _buildScrollableColumn(
              controller: _hourController,
              items: List.generate(12, (index) => (index + 1).toString().padLeft(2, '0')),
              onChanged: (index) {
                setState(() {
                  selectedHour = index + 1;
                });
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              ':',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textcolor,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: _buildScrollableColumn(
              controller: _minuteController,
              items: List.generate(60, (index) => index.toString().padLeft(2, '0')),
              onChanged: (index) {
                setState(() {
                  selectedMinute = index;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 1,
            child: _buildScrollableColumn(
              controller: _periodController,
              items: const ['AM', 'PM'],
              onChanged: (index) {
                setState(() {
                  isPM = index == 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required Function(int) onChanged,
  }) {
    return SizedBox(
      height: 200,
      child: ListWheelScrollView(
        controller: controller,
        itemExtent: 40,
        onSelectedItemChanged: onChanged,
        physics: const FixedExtentScrollPhysics(),
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = _isItemSelected(controller, index);
          return SizedBox(
            height: 40,
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                  fontSize: isSelected ? 18 : 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected ? AppColors.textcolor : Colors.grey,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  bool _isItemSelected(FixedExtentScrollController controller, int index) {
    if (controller == _hourController) {
      return selectedHour - 1 == index;
    } else if (controller == _minuteController) {
      return selectedMinute == index;
    } else if (controller == _periodController) {
      return (isPM ? 1 : 0) == index;
    }
    return false;
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onClose,
                borderRadius: BorderRadius.circular(12),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textcolor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  final hour24 = isPM
                      ? (selectedHour % 12) + 12
                      : (selectedHour % 12);
                  final time = TimeOfDay(hour: hour24, minute: selectedMinute);
                  widget.onTimeSelected(time);
                  widget.onClose();
                },
                borderRadius: BorderRadius.circular(12),
                child: const Center(
                  child: Text(
                    'Save Time',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


