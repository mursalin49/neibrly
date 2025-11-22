import 'package:flutter/material.dart';
import 'package:naibrly/models/user_request.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/screen/Users/Request/payment_information_screen.dart';

class ReviewConfirmScreen extends StatefulWidget {
  final UserRequest request;

  const ReviewConfirmScreen({
    super.key,
    required this.request,
  });

  @override
  State<ReviewConfirmScreen> createState() => _ReviewConfirmScreenState();
}

class _ReviewConfirmScreenState extends State<ReviewConfirmScreen> {
  final TextEditingController _tipController = TextEditingController(text: '10');
  double _tipAmount = 10.0;

  @override
  void initState() {
    super.initState();
    _tipController.addListener(_updateTipAmount);
  }

  @override
  void dispose() {
    _tipController.dispose();
    super.dispose();
  }

  void _updateTipAmount() {
    final tipText = _tipController.text.replaceAll('\$', '').trim();
    final tip = double.tryParse(tipText) ?? 0.0;
    setState(() {
      _tipAmount = tip;
    });
  }

  double get _totalAmount => widget.request.averagePrice + _tipAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppText(
          'Review and confirm',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Details Section
            AppText(
              widget.request.serviceName,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.Black,
            ),
            const SizedBox(height: 6),
            AppText(
              'Request Amount: \$${widget.request.averagePrice.toInt()}/consult',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.Black,
            ),
            const SizedBox(height: 3),
            AppText(
              'Date: ${widget.request.formattedDate}',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.DarkGray,
            ),
            
            const SizedBox(height: 24),
            
            // Service Provider Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Provider image
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(widget.request.providerImage),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          widget.request.providerName,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.Black,
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 3),
                            AppText(
                              '${widget.request.providerRating} (${widget.request.providerReviewCount} reviews)',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.DarkGray,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Tips Section
            AppText(
              'Tips',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.Black,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _tipController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: '\$ ',
                  border: InputBorder.none,
                  hintText: '10',
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Total Amount
            Center(
              child: AppText(
                '\$${_totalAmount.toInt()}',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0E7A60),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Confirm and Payment Button
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: _handleConfirmPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7A60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: AppText(
                  'Confirm and payment',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Terms & Condition Link
            Center(
              child: GestureDetector(
                onTap: _showTermsAndConditions,
                child: AppText(
                  'Terms & Condition',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF0E7A60),
                  decoration: TextDecoration.underline,
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
    // Navigate to payment information screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentInformationScreen(
          request: widget.request,
          totalAmount: _totalAmount,
        ),
      ),
    );
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppText(
          'Terms & Conditions',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.Black,
        ),
        content: AppText(
          'By confirming this payment, you agree to our terms and conditions. The service will be provided as scheduled and payment will be processed securely.',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.DarkGray,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AppText(
              'Close',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0E7A60),
            ),
          ),
        ],
      ),
    );
  }
}
