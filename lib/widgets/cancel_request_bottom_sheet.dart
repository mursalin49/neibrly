import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';

class CancelRequestBottomSheet extends StatefulWidget {
  final ValueChanged<String>? onCancelConfirmed;

  const CancelRequestBottomSheet({
    super.key,
    this.onCancelConfirmed,
  });

  @override
  State<CancelRequestBottomSheet> createState() => _CancelRequestBottomSheetState();
}

class _CancelRequestBottomSheetState extends State<CancelRequestBottomSheet> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Cancel icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEEEEE), // Light red background
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFF34F4F), // Red border
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/images/cross.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.close,
                          color: Color(0xFFF34F4F),
                          size: 40,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Title
                AppText(
                  'Are you sure!',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.Black,
                ),
                const SizedBox(height: 8),
                
                // Subtitle
                AppText(
                  'you want to cancel this order?',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.DarkGray,
                ),
                const SizedBox(height: 32),
                
                // Reason input section
                Column(
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
                      controller: _reasonController,
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
                const SizedBox(height: 32),
                
                // Cancel button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_reasonController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: AppText(
                              'Please provide a reason for cancellation',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      
                      widget.onCancelConfirmed?.call(_reasonController.text.trim());
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF34F4F), // Red background
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: AppText(
                      'Cancelled',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
    );
  }
}
