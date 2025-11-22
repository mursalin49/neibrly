import 'package:flutter/material.dart';
import 'colors.dart';

Future<TimeOfDay?> showCustomTimePickerSheet(
  BuildContext context, {
  required TimeOfDay initialTime,
}) async {
  return await showModalBottomSheet<TimeOfDay>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return _TimePickerContent(initialTime: initialTime);
    },
  );
}

class _TimePickerContent extends StatefulWidget {
  final TimeOfDay initialTime;
  const _TimePickerContent({required this.initialTime});

  @override
  State<_TimePickerContent> createState() => _TimePickerContentState();
}

class _TimePickerContentState extends State<_TimePickerContent> {
  late int _hour; // 1-12
  late int _minute; // 0-59
  late bool _isAm; // true AM, false PM

  @override
  void initState() {
    super.initState();
    _isAm = widget.initialTime.period == DayPeriod.am;
    int h = widget.initialTime.hourOfPeriod;
    _hour = h == 0 ? 12 : h;
    _minute = widget.initialTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPicker(
                    label: 'Hour',
                    itemCount: 12,
                    initialIndex: _hour - 1,
                    selectedIndex: _hour - 1,
                    itemBuilder: (i) => (i + 1).toString().padLeft(2, '0'),
                    onSelected: (i) => setState(() => _hour = i + 1),
                  ),
                  _buildPicker(
                    label: 'Min',
                    itemCount: 60,
                    initialIndex: _minute,
                    selectedIndex: _minute,
                    itemBuilder: (i) => i.toString().padLeft(2, '0'),
                    onSelected: (i) => setState(() => _minute = i),
                  ),
                  _buildAmPm(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KoreColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    final int hour24 = (_hour % 12) + (_isAm ? 0 : 12);
                    Navigator.of(context).pop(TimeOfDay(hour: hour24, minute: _minute));
                  },
                  child: const Text(
                    'Select',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPicker({
    required String label,
    required int itemCount,
    required int initialIndex,
    required int selectedIndex,
    required String Function(int) itemBuilder,
    required void Function(int) onSelected,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9E9E9E),
          ),
        ),
        SizedBox(
          width: 90,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Wheel
              ListWheelScrollView.useDelegate(
                itemExtent: 36,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: onSelected,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    if (index < 0 || index >= itemCount) return null;
                    final bool isSelected = index == selectedIndex;
                    return Center(
                      child: Text(
                        itemBuilder(index),
                        style: TextStyle(
                          fontSize: isSelected ? 20 : 16,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? KoreColors.primary
                              : const Color(0xFF1F1D1D).withOpacity(0.6),
                        ),
                      ),
                    );
                  },
                  childCount: itemCount,
                ),
              ),
              // Selection highlight
              IgnorePointer(
                child: Container(
                  width: double.infinity,
                  height: 36,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: KoreColors.primary.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: KoreColors.primary, width: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmPm() {
    return Column(
      children: [
        const Text(
          'AM/PM',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF9E9E9E),
          ),
        ),
        const SizedBox(height: 8),
        ToggleButtons(
          isSelected: [_isAm, !_isAm],
          borderRadius: BorderRadius.circular(8),
          selectedColor: Colors.white,
          color: const Color(0xFF1F1D1D),
          fillColor: KoreColors.primary,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text(
                'AM',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text(
                'PM',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          onPressed: (i) => setState(() => _isAm = i == 0),
        ),
      ],
    );
  }
}

