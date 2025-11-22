import 'package:flutter/material.dart';
import 'dart:math';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/provider/models/order.dart';
import 'package:naibrly/widgets/naibrly_now_bottom_sheet.dart';
import 'package:naibrly/provider/screens/order_inbox_screen.dart';
import 'package:naibrly/views/base/pickers/custom_date_picker.dart';
import 'package:naibrly/views/base/pickers/custom_time_picker.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget? topIcon;
  final Color? topIconBackgroundColor;
  final String? imagePath;
  final double? imageHeight;
  final double? imageWidth;
  final String title;
  final String description;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback? onPrimaryButtonTap;
  final VoidCallback? onSecondaryButtonTap;
  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;
  final Color? primaryButtonTextColor;
  final Color? secondaryButtonTextColor;
  final Color? secondaryButtonBorderColor;
  final double? containerHeight;
  final bool showSecondaryButton;
  final bool showRating;
  final bool showFeedback;
  final Function(int)? onRatingChanged;
  final Function(String)? onFeedbackChanged;
  final Widget? customContent;
  final bool isTopIconClickable;

  const CustomBottomSheet({
    super.key,
    this.topIcon,
    this.topIconBackgroundColor,
    this.imagePath,
    this.imageHeight = 100,
    this.imageWidth = 100,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    this.secondaryButtonText = '',
    this.onPrimaryButtonTap,
    this.onSecondaryButtonTap,
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.primaryButtonTextColor,
    this.secondaryButtonTextColor,
    this.secondaryButtonBorderColor,
    this.containerHeight = 350,
    this.showSecondaryButton = true,
    this.showRating = false,
    this.showFeedback = false,
    this.onRatingChanged,
    this.onFeedbackChanged,
    this.customContent,
    this.isTopIconClickable = true,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int _selectedRating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.85; // Use 85% of screen height
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top Icon
        if (widget.topIcon != null) ...[
          GestureDetector(
            onTap: widget.isTopIconClickable ? () => Navigator.of(context).pop() : null,
            child: Container(
              width: 48,
              height: 48,
              child: widget.topIcon,
            ),
          ),
          const SizedBox(height: 16),
        ],
        
        // Main Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            color: AppColors.White,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
              children: [
              // Image
              if (widget.imagePath != null) ...[
                Image.asset(
                  widget.imagePath!,
                  height: widget.imageHeight,
                  width: widget.imageWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: widget.imageHeight,
                      width: widget.imageWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],

              SizedBox(height: 16),
              
              // Title (optional)
              if (widget.title.trim().isNotEmpty) ...[
                AppText(
                  widget.title,
                  color: AppColors.textcolor,
                  fontSize: 18,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),
              ],
              
              // Description (optional)
              if (widget.description.trim().isNotEmpty) ...[
                AppText(
                  widget.description,
                  color: AppColors.textcolor.withOpacity(0.70),
                  fontSize: 15,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w300,
                ),
                const SizedBox(height: 16),
              ],
              
              // Rating Section
              if (widget.showRating) ...[
                AppText(
                  "Rate your experience",
                  color: AppColors.textcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRating = index + 1;
                        });
                        widget.onRatingChanged?.call(_selectedRating);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          index < _selectedRating ? Icons.star : Icons.star_border,
                          color: index < _selectedRating ? Colors.amber : Colors.grey,
                          size: 32,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
              ],
              
              // Feedback Section
              if (widget.showFeedback) ...[
                AppText(
                  "Share your feedback",
                  color: AppColors.textcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _feedbackController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Tell us about your experience...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (value) {
                      widget.onFeedbackChanged?.call(value);
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
              
              // Custom Content
              if (widget.customContent != null) ...[
                widget.customContent!,
                const SizedBox(height: 16),
              ],
              
              // Buttons
              if (widget.showSecondaryButton && widget.secondaryButtonText.isNotEmpty)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.secondaryButtonColor ?? AppColors.black.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(8),
                          border: widget.secondaryButtonBorderColor != null 
                            ? Border.all(color: widget.secondaryButtonBorderColor!, width: 0.5)
                            : null,
                        ),
                        child: TextButton(
                          onPressed: widget.onSecondaryButtonTap ?? () => Navigator.of(context).pop(),
                          child: AppText(
                            widget.secondaryButtonText,
                            color: widget.secondaryButtonTextColor ?? AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.primaryButtonColor ?? const Color(0xFF0E7A60),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: widget.onPrimaryButtonTap ?? () => Navigator.of(context).pop(),
                          child: AppText(
                            widget.primaryButtonText,
                            color: widget.primaryButtonTextColor ?? Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.primaryButtonColor ?? const Color(0xFF0E7A60),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: widget.onPrimaryButtonTap ?? () => Navigator.of(context).pop(),
                      child: AppText(
                        widget.primaryButtonText,
                        color: widget.primaryButtonTextColor ?? Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              
              // Bottom spacing
              const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        ),
      ],
    );
  }
}

// Global function to show custom bottom sheet
void showCustomBottomSheet({
  required BuildContext context,
  Widget? topIcon,
  Color? topIconBackgroundColor,
  String? imagePath,
  double? imageHeight,
  double? imageWidth,
  required String title,
  required String description,
  required String primaryButtonText,
  String secondaryButtonText = '',
  VoidCallback? onPrimaryButtonTap,
  VoidCallback? onSecondaryButtonTap,
  Color? primaryButtonColor,
  Color? secondaryButtonColor,
  Color? primaryButtonTextColor,
  Color? secondaryButtonTextColor,
  Color? secondaryButtonBorderColor,
  double? containerHeight,
  bool showSecondaryButton = true,
  bool showRating = false,
  bool showFeedback = false,
  Function(int)? onRatingChanged,
  Function(String)? onFeedbackChanged,
  Widget? customContent,
  bool isTopIconClickable = true,
}) {
  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    barrierColor: const Color(0xFF030306).withOpacity(0.90),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => CustomBottomSheet(
      topIcon: topIcon,
      topIconBackgroundColor: topIconBackgroundColor,
      imagePath: imagePath,
      imageHeight: imageHeight,
      imageWidth: imageWidth,
      title: title,
      description: description,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      onPrimaryButtonTap: onPrimaryButtonTap,
      onSecondaryButtonTap: onSecondaryButtonTap,
      primaryButtonColor: primaryButtonColor,
      secondaryButtonColor: secondaryButtonColor,
      primaryButtonTextColor: primaryButtonTextColor,
      secondaryButtonTextColor: secondaryButtonTextColor,
      secondaryButtonBorderColor: secondaryButtonBorderColor,
      containerHeight: containerHeight,
      showSecondaryButton: showSecondaryButton,
      showRating: showRating,
      showFeedback: showFeedback,
      onRatingChanged: onRatingChanged,
      onFeedbackChanged: onFeedbackChanged,
      customContent: customContent,
      isTopIconClickable: isTopIconClickable,
    ),
  );
}

void showPaymentConfirmationBottomSheet(BuildContext context) {
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.check,
          color: Color(0xFF00CD49),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/tickMark.png",
    imageHeight: 80,
    imageWidth: 80,
    title: "Payment Confirmed",
    description: "Your payment has been processed successfully. \nYou will receive a confirmation email shortly.",
    primaryButtonText: "Done",
    showSecondaryButton: false,
    showRating: true,
    showFeedback: true,
    containerHeight: 450,
    onRatingChanged: (rating) {
      print("Rating: $rating stars");
    },
    onFeedbackChanged: (feedback) {
      print("Feedback: $feedback");
    },
    onPrimaryButtonTap: () {
      Navigator.of(context).pop();
      // Navigate back to inbox
      Navigator.of(context).pop(); // Payment screen
      Navigator.of(context).pop(); // Review screen
      Navigator.of(context).pop(); // Inbox screen
    },
  );
}

// Cancel Request Bottom Sheet
void showCancelRequestBottomSheet(BuildContext context, {ValueChanged<String>? onCancelConfirmed, VoidCallback? onNaibrlyNow}) {
  final TextEditingController reasonController = TextEditingController();
  
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.close,
          color: Color(0xFFF34F4F),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/cross.png",
    imageHeight: 80,
    imageWidth: 80,
    title: "Are you sure!",
    description: "you want to cancel this order?",
    primaryButtonText: "Cancelled",
    showSecondaryButton: true,
    secondaryButtonText: "Naibrly Now",
    secondaryButtonColor: const Color(0xFF0E7A60),
    secondaryButtonTextColor: Colors.white,
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFFF34F4F),
    containerHeight: 500,
    customContent: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Note why*',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.Black,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: reasonController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Type here',
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
              borderSide: const BorderSide(color: Color(0xFFF34F4F), width: 1),
            ),
            contentPadding: const EdgeInsets.all(12),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    ),
    onPrimaryButtonTap: () {
      if (reasonController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide a reason for cancellation'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      onCancelConfirmed?.call(reasonController.text.trim());
      Navigator.of(context).pop();
    },
    onSecondaryButtonTap: () {
      Navigator.of(context).pop();
      onNaibrlyNow?.call();
    },
  );
}

// Pending Request Bottom Sheet
void showPendingRequestBottomSheet(BuildContext context, {String timeLimit = "16:30"}) {
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.schedule,
          color: Color(0xFFF3934F),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/pending.png",
    imageHeight: 80,
    imageWidth: 80,
    title: "Request Pending",
    description: "Your request is pending approval. \nWe'll notify you once it's accepted.",
    primaryButtonText: "OK",
    showSecondaryButton: false,
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFFF3934F),
    containerHeight: 250,
    customContent: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4E6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFF3934F),
              width: 1,
            ),
          ),
          child: AppText(
            'Time Limit: $timeLimit',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF3934F),
          ),
        ),
      ],
    ),
    onPrimaryButtonTap: () {
      Navigator.of(context).pop();
    },
  );
}

// Request Service Bottom Sheet
void showRequestServiceBottomSheet(BuildContext context, {required String serviceName, required String providerName}) {
  final TextEditingController problemController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  
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
    imagePath: "assets/images/Group 1686559613.png",
    imageHeight: 120,
    imageWidth: 159,
    title: "Request Service",
    description: "Fill in the details to request this service",
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
        // Service Info
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Service: $serviceName',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.Black,
              ),
              const SizedBox(height: 4),
              AppText(
                'Provider: $providerName',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.DarkGray,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Time*',
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
                        builder: (_) => CustomTimePicker(
                          selectedTime: selectedTime,
                          onTimeSelected: (t) {
                            selectedTime = t;
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
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          AppText(
                            selectedTime != null 
                              ? selectedTime!.format(context)
                              : 'Select Time',
                            fontSize: 14,
                            color: selectedTime != null ? AppColors.Black : Colors.grey,
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
      
      if (selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a time'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
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

// Request Success Bottom Sheet
void showRequestSuccessBottomSheet(BuildContext context) {
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.check_circle,
          color: Color(0xFF00CD49),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/tickMark.png",
    imageHeight: 100,
    imageWidth: 100,
    title: "Request Sent Successfully!",
    description: "Your service request has been sent. \nWe'll notify you once it's accepted.",
    primaryButtonText: "OK",
    showSecondaryButton: false,
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFF00CD49),
    containerHeight: 400,
    onPrimaryButtonTap: () {
      Navigator.of(context).pop();
    },
  );
}

// Request Failed Bottom Sheet
void showRequestFailedBottomSheet(BuildContext context) {
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.error,
          color: Color(0xFFF34F4F),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/cross.png",
    imageHeight: 100,
    imageWidth: 100,
    title: "Request Failed",
    description: "Sorry, your request could not be sent. \nPlease try again later.",
    primaryButtonText: "Try Again",
    showSecondaryButton: true,
    secondaryButtonText: "Cancel",
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFFF34F4F),
    secondaryButtonColor: Colors.grey.shade300,
    containerHeight: 300,
    onPrimaryButtonTap: () {
      Navigator.of(context).pop();
    },
    onSecondaryButtonTap: () {
      Navigator.of(context).pop();
    },
  );
}

// ==================== PROVIDER BOTTOM SHEETS ====================

// Withdraw Bottom Sheet
void showWithdrawBottomSheet(BuildContext context, {required VoidCallback onSuccess}) {
  final TextEditingController amountController = TextEditingController(text: "500");
  
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.account_balance_wallet,
          color: Color(0xFF0E7A60),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/Group 1686559613.png",
    imageHeight: 80,
    imageWidth: 80,
    title: "Withdraw Funds",
    description: "Enter the amount you want to withdraw",
    primaryButtonText: "Withdraw",
    showSecondaryButton: false,
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFF0E7A60),
    containerHeight: 400,
    customContent: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Amount',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter amount',
            prefixText: '\$ ',
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
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: AppText(
                  'Minimum withdrawal amount is \$50',
                  fontSize: 12,
                  color: Colors.blue[600],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    onPrimaryButtonTap: () {
      final amount = double.tryParse(amountController.text);
      if (amount == null || amount < 50) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Minimum withdrawal amount is \$50'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      Navigator.of(context).pop();
      onSuccess();
    },
  );
}

// Success Bottom Sheet
void showSuccessBottomSheet(BuildContext context, {String? message}) {
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.check_circle,
          color: Color(0xFF00CD49),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/tickMark.png",
    imageHeight: 80,
    imageWidth: 80,
    title: "Success!",
    description: message ?? "Your withdrawal request has been successfully sent to Admin",
    primaryButtonText: "OK",
    showSecondaryButton: false,
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFF00CD49),
    containerHeight: 300,
    onPrimaryButtonTap: () {
      Navigator.of(context).pop();
    },
  );
}

// Cancel Order Bottom Sheet
void showCancelOrderBottomSheet(BuildContext context, {required String orderId, VoidCallback? onConfirmCancel}) {
  final TextEditingController reasonController = TextEditingController();
  
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.cancel,
          color: Color(0xFFF34F4F),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/cross.png",
    imageHeight: 80,
    imageWidth: 80,
    title: "Cancel Order",
    description: "Are you sure you want to cancel this order?",
    primaryButtonText: "Cancel Order",
    showSecondaryButton: true,
    secondaryButtonText: "Keep Order",
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFFF34F4F),
    secondaryButtonColor: Colors.grey.shade300,
    containerHeight: 400,
    customContent: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Reason for cancellation',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Please provide a reason...',
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
              borderSide: const BorderSide(color: Color(0xFFF34F4F), width: 1),
            ),
            contentPadding: const EdgeInsets.all(12),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    ),
    onPrimaryButtonTap: () {
      if (reasonController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide a reason for cancellation'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      Navigator.of(context).pop();
      onConfirmCancel?.call();
    },
    onSecondaryButtonTap: () {
      Navigator.of(context).pop();
    },
  );
}

// Order Details Bottom Sheet
void showOrderDetailsBottomSheet(BuildContext context, {required Map<String, dynamic> orderData}) {
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.receipt,
          color: Color(0xFF0E7A60),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/Group 1686559613.png", // Remove the main image
    imageHeight: 150,
    imageWidth: 150,
    title: "", // Empty title since we'll show service name in custom content
    description: "", // Empty description
    primaryButtonText: "Accept",
    secondaryButtonText: "Cancel",
    secondaryButtonTextColor: const Color(0xFFF34F4F),
    showSecondaryButton: true,
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFF0E7A60),
    secondaryButtonColor: const Color(0xFFFEEEEE),
    secondaryButtonBorderColor: const Color(0xFFFCCBCB),
    containerHeight: 500,
    customContent: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Service Header
        Row(
          children: [
            AppText(
              "${orderData['service'] ?? 'Service'}:",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.Black,
            ),
            const SizedBox(width: 8),
            AppText(
              "\$${orderData['amount'] ?? '0'}/hr",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0E7A60),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Provider Information
        Row(
          children: [
            // Provider Image
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/jane.png"), // Default provider image
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(width: 12),
            // Provider Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    orderData['customer'] ?? 'Provider Name',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.Black,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      AppText(
                        "5.0 (55 reviews)",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Address
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "Address:",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.Black,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText(
                "123 Oak Street Springfield, IL 62704", // Default address
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.DarkGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Date and Time
        AppText(
          "Date: 18 Sep 2025 Time: 14:00", // Default date/time
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.DarkGray,
        ),
        const SizedBox(height: 16),
        
        // Problem Note Section
        AppText(
          "Problem Note for ${orderData['service'] ?? 'Service'}",
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.Black,
        ),
        const SizedBox(height: 8),
        AppText(
          orderData['notes'] ?? "The fridge is not cooling properly, making strange noises, freezing food, leaking water, etc.",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.DarkGray,
        ),
      ],
    ),
    onPrimaryButtonTap: () {
      Navigator.of(context).pop();
      // Update order status to accepted and navigate to Order Inbox
      _handleAcceptOrder(context, orderData);
    },
    onSecondaryButtonTap: () {
      Navigator.of(context).pop();
      // Show cancellation bottom sheet
      showOrderCancellationBottomSheet(context, orderData: orderData);
    },
  );
}

// Handle Accept Order Logic
void _handleAcceptOrder(BuildContext context, Map<String, dynamic> orderData) {
  // TODO: Update order status in your data model/API
  print("Order accepted: ${orderData['id']}");
  
  // Create updated order data with accepted status
  final updatedOrderData = Map<String, dynamic>.from(orderData);
  updatedOrderData['status'] = 'accepted';
  
  // Navigate to Order Inbox Screen with accepted status
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => OrderInboxScreen(
        order: _createOrderFromData(updatedOrderData),
      ),
    ),
  );
}

// Helper function to create Order object from orderData
Order _createOrderFromData(Map<String, dynamic> orderData) {
  return Order(
    id: orderData['id'] ?? '1',
    serviceName: orderData['service'] ?? 'Service',
    averagePrice: double.tryParse(orderData['amount']?.toString() ?? '0') ?? 0.0,
    date: DateTime.now(),
    time: "14:00",
    imagePath: "assets/images/repares.png",
    status: OrderStatus.accepted, // Set to accepted status
    problemDescription: orderData['notes'] ?? 'Service request',
    clientName: orderData['customer'] ?? 'Customer',
    clientImage: "assets/images/jane.png",
    clientRating: 5.0,
    clientReviewCount: 55,
    address: "123 Oak Street Springfield, IL 62704",
  );
}

// Order Cancellation Bottom Sheet
void showOrderCancellationBottomSheet(BuildContext context, {required Map<String, dynamic> orderData}) {
  showCustomBottomSheet(
    context: context,
    topIcon: Image.asset(
      "assets/images/roundCross.png",
      width: 48,
      height: 48,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.check,
          color: Color(0xFF00CD49),
          size: 48,
        );
      },
    ),
    imagePath: "assets/images/cross.png", // Remove the main image
    title: "Are you sure!",
    description: "you want to cancel this order?",
    primaryButtonText: "Cancelled",
    showSecondaryButton: true,
    secondaryButtonText: "Naibrly Now",
    secondaryButtonColor: const Color(0xFF0E7A60),
    secondaryButtonTextColor: Colors.white,
    showRating: false,
    showFeedback: false,
    primaryButtonColor: const Color(0xFFFF6B6B),
    containerHeight: 350,
    customContent: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        AppText(
          'Note why*',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Type here",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            maxLines: 3,
          ),
        ),
      ],
    ),
    onPrimaryButtonTap: () {
      Navigator.of(context).pop();
      // TODO: Handle order cancellation logic
      print("Order cancelled: ${orderData['id']}");
    },
    onSecondaryButtonTap: () {
      Navigator.of(context).pop();
      showNaibrlyNowBottomSheet(
        context,
        serviceName: orderData['service']?.toString() ?? 'Service',
        providerName: orderData['customer']?.toString() ?? 'Provider',
      );
    },
  );
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: AppText(
            '$label:',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.DarkGray,
          ),
        ),
        Expanded(
          child: AppText(
            value,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.Black,
          ),
        ),
      ],
    ),
  );
}
