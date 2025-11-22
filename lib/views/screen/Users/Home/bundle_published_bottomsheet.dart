import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';

class BundlePublishedBottomSheet extends StatelessWidget {
  const BundlePublishedBottomSheet({super.key});

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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            // Container(
            //   width: 80,
            //   height: 80,
            //   decoration: BoxDecoration(
            //     color: const Color(0xFFE8F5E9), // Light green background
            //     shape: BoxShape.circle,
            //     border: Border.all(
            //       color: AppColors.primary, // Dark green border
            //       width: 2,
            //     ),
            //   ),
              //child:
              Center(
                child: Image.asset(
                  'assets/images/tickMark.png',
                  width: 120,
                  height: 120,
                ),
              ),
            //),
            const SizedBox(height: 24),
            
            // Main Title
            const AppText(
              "Your Bundle has been Published",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            // Subtitle
            AppText(
              "share with friends and neighbors",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textcolor,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Share with text/email button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: IosTapEffect(
                onTap: () {
                  // Handle share with text/email
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Share with text/email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0E7A60),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Share with QR button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: IosTapEffect(
                onTap: () {
                  // Handle share with QR
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Share with QR",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0E7A60),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
