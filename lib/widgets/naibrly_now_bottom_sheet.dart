import 'dart:math';
import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/pickers/custom_date_picker.dart';
import 'package:naibrly/widgets/payment_confirmation_bottom_sheet.dart';

// Global helper to show the reusable "Naibrly Now" request bottom sheet
void showNaibrlyNowBottomSheet(
  BuildContext context, {
  required String serviceName,
  required String providerName,
}) {
  final TextEditingController problemController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;
  // No time selection in this sheet

  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.add,
          color: Color(0xFF0E7A60),
          size: 48,
        );
      },
    ),
    // No hero image; suppress title/description with empty strings
    title: "",
    description: "",
    primaryButtonText: "Request Sent",
    showSecondaryButton: false,
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFF0E7A60),
    containerHeight: 600,
    customContent: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Info removed per requirements

            // Problem Field
            AppText(
              'Problem*',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.Black,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: problemController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe your problem...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF0E7A60), width: 1),
                ),
                contentPadding: const EdgeInsets.all(12),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Note Field
            AppText(
              'Note',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.Black,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Additional notes...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF0E7A60), width: 1),
                ),
                contentPadding: const EdgeInsets.all(12),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Date and Time Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Date*',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Black,
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => CustomDatePicker(
                              selectedDate: selectedDate,
                              onDateSelected: (d) {
                                selectedDate = d;
                                setState(() {});
                              },
                              onClose: () => Navigator.of(context).pop(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              AppText(
                                selectedDate != null 
                                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                  : 'Select Date',
                                fontSize: 14,
                                color: selectedDate != null ? AppColors.Black : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
    onPrimaryButtonTap: () {
      if (problemController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please describe your problem'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a date'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // No time selection required

      Navigator.of(context).pop();

      // Simulate random success/failure
      final random = Random();
      final isSuccess = random.nextBool();

      Future.delayed(const Duration(milliseconds: 500), () {
        if (isSuccess) {
          showRequestSuccessBottomSheet(context);
        } else {
          showRequestFailedBottomSheet(context);
        }
      });
    },
  );
}


