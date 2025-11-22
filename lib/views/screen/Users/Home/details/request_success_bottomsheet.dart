import 'package:flutter/material.dart';
import 'package:naibrly/views/base/AppText/appText.dart';

class RequestSuccessBottomSheet extends StatelessWidget {
  final String providerName;

  const RequestSuccessBottomSheet({
    Key? key,
    required this.providerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          _buildSuccessIcon(),
          
          const SizedBox(height: 24),
          
          // Success Title
          const AppText(
            "Your request has been submitted",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          
          const SizedBox(height: 8),
          
          // Response Time Details
          AppText(
            "Average response time: 10 minutes (by $providerName)",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
          
          const SizedBox(height: 32),
          
          // Go Home Button
          _buildGoHomeButton(context),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Shadow
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        // Main Icon Container
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.shade50,
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
          ),
          child: Image.asset(
            'assets/images/tickMark.png',
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }

  Widget _buildGoHomeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context); // Close success bottom sheet
          Navigator.pop(context); // Close request bottom sheet
          Navigator.pop(context); // Go back to home
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0E7A60),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const AppText(
          "Go Home",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
