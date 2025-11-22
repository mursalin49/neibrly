import 'package:flutter/material.dart';
import 'package:naibrly/views/base/AppText/appText.dart';

class RequestFailedBottomSheet extends StatelessWidget {
  final String providerName;

  const RequestFailedBottomSheet({
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
          // Failed Icon
          _buildFailedIcon(),
          
          const SizedBox(height: 24),
          
          // Failed Title
          const AppText(
            "We're sorry",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          
          const SizedBox(height: 16),
          
          // Error Message
          AppText(
            "It looks like $providerName is no longer available at this time.",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 32),
          
          // Choose Another Provider Button
          _buildChooseAnotherButton(context),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFailedIcon() {
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
            color: Colors.red.shade50,
            border: Border.all(
              color: Colors.red,
              width: 2,
            ),
          ),
          child: Image.asset(
            'assets/images/cross.png',
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }

  Widget _buildChooseAnotherButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context); // Close failed bottom sheet
          Navigator.pop(context); // Close request bottom sheet
          Navigator.pop(context); // Go back to provider list
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const AppText(
          "Choose another provider",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
