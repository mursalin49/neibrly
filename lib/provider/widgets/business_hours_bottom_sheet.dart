import 'package:flutter/material.dart';
import 'colors.dart';
import 'custom_time_picker.dart';

class BusinessHoursBottomSheet extends StatefulWidget {
  final List<DayHours> initialHours;
  final Function(List<DayHours>) onSave;

  const BusinessHoursBottomSheet({
    super.key,
    required this.initialHours,
    required this.onSave,
  });

  @override
  State<BusinessHoursBottomSheet> createState() => _BusinessHoursBottomSheetState();
}

class _BusinessHoursBottomSheetState extends State<BusinessHoursBottomSheet> {
  late List<DayHours> businessHours;

  @override
  void initState() {
    super.initState();
    businessHours = List<DayHours>.from(widget.initialHours);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set Standard Hours",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1C1C1C),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Configure the standard hours of operation for this location.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          // Days list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: businessHours.length,
              itemBuilder: (context, index) {
                return _buildDayRow(businessHours[index]);
              },
            ),
          ),
          
          // Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color(0xFF1C1C1C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onSave(businessHours);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KoreColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Save Schedule",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDayRow(DayHours dayHours) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Day name
              Expanded(
                child: Text(
                  dayHours.dayName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1C1C1C),
                  ),
                ),
              ),
              
              // Toggle
              GestureDetector(
                onTap: () {
                  setState(() {
                    dayHours.isOpen = !dayHours.isOpen;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: dayHours.isOpen 
                        ? KoreColors.primary.withOpacity(0.15) 
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dayHours.isOpen ? "Open" : "Closed",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: dayHours.isOpen 
                              ? KoreColors.primary 
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 22,
                        height: 14,
                        decoration: BoxDecoration(
                          color: dayHours.isOpen 
                              ? KoreColors.primary 
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              left: dayHours.isOpen ? 10 : 2,
                              top: 2,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Time pickers (only if open)
          if (dayHours.isOpen) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTimePicker(
                    label: "Start",
                    time: dayHours.startTime,
                    onChanged: (newTime) {
                      setState(() {
                        dayHours.startTime = newTime;
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "TO",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF888888),
                    ),
                  ),
                ),
                Expanded(
                  child: _buildTimePicker(
                    label: "End",
                    time: dayHours.endTime,
                    onChanged: (newTime) {
                      setState(() {
                        dayHours.endTime = newTime;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay time,
    required Function(TimeOfDay) onChanged,
  }) {
    final timeStr = _formatTime(time);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final picked = await showCustomTimePickerSheet(
                context,
                initialTime: time,
              );
              if (picked != null) {
                onChanged(picked);
              }
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 12, top: 4),
                    child: Text(
                      timeStr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1C1C1C),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Increment by 15 minutes
                          final totalMinutes = time.hour * 60 + time.minute;
                          final newTotalMinutes = (totalMinutes + 15) % (24 * 60);
                          final newHour = newTotalMinutes ~/ 60;
                          final newMinute = newTotalMinutes % 60;
                          onChanged(TimeOfDay(hour: newHour, minute: newMinute));
                        },
                        child: const Icon(Icons.arrow_drop_up, size: 20, color: Color(0xFF888888)),
                      ),
                      InkWell(
                        onTap: () {
                          // Decrement by 15 minutes
                          final totalMinutes = time.hour * 60 + time.minute;
                          final newTotalMinutes = (totalMinutes - 15 + (24 * 60)) % (24 * 60);
                          final newHour = newTotalMinutes ~/ 60;
                          final newMinute = newTotalMinutes % 60;
                          onChanged(TimeOfDay(hour: newHour, minute: newMinute));
                        },
                        child: const Icon(Icons.arrow_drop_down, size: 20, color: Color(0xFF888888)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

class DayHours {
  String dayName;
  bool isOpen;
  TimeOfDay startTime;
  TimeOfDay endTime;

  DayHours({
    required this.dayName,
    this.isOpen = false,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  })  : startTime = startTime ?? const TimeOfDay(hour: 9, minute: 0),
        endTime = endTime ?? const TimeOfDay(hour: 17, minute: 0);
}

