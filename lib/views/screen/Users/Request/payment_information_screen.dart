import 'package:flutter/material.dart';
import 'package:naibrly/models/user_request.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/widgets/payment_confirmation_bottom_sheet.dart';

class PaymentInformationScreen extends StatefulWidget {
  final UserRequest request;
  final double totalAmount;

  const PaymentInformationScreen({
    super.key,
    required this.request,
    required this.totalAmount,
  });

  @override
  State<PaymentInformationScreen> createState() => _PaymentInformationScreenState();
}

class _PaymentInformationScreenState extends State<PaymentInformationScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.DarkGray),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppText(
          'Payment information',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main instruction
            AppText(
              'Please enter payment information',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.Black,
            ),
            
            const SizedBox(height: 24),
            
            // Pay With section
            AppText(
              'Pay With:',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.Black,
            ),
            
            const SizedBox(height: 16),
            
            // Card Number
            AppText(
              'Card Number',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.Black,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '1234 5678 9101 1121',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Expiration Date and CVV Row
            Row(
              children: [
                // Expiration Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Expiration Date',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Black,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _expiryController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'MM/YY',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // CVV
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'CVV',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Black,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: '123',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Security Information Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E8), // Light green background
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Security icon
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E7A60),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.security,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Your information is secure',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.DarkGray,
                        ),
                        const SizedBox(height: 4),
                        AppText(
                          'We use bank-level encryption and Stripe to protect your payment information',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _handleConfirmPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7A60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: AppText(
                  'Confirm',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _handleConfirmPayment() {
    // Validate form
    if (_cardNumberController.text.isEmpty || 
        _expiryController.text.isEmpty || 
        _cvvController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all payment details'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0E7A60)),
        ),
      ),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading dialog
      
      // Show payment confirmation bottom sheet
      showPaymentConfirmationBottomSheet(context);
    });
  }
}
