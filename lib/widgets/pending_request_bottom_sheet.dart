import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';

class PendingRequestBottomSheet extends StatelessWidget {
  final String timeLimit;

  const PendingRequestBottomSheet({
    super.key,
    this.timeLimit = "16:30",
  });

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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.LightGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            
            // Pending icon
            // Container(
            //   width: 80,
            //   height: 80,
            //   decoration: BoxDecoration(
            //     color: const Color(0xFFFFF4E6), // Light orange background
            //     shape: BoxShape.circle,
            //   ),
            //   child: Center(
            //     child: Container(
            //       width: 60,
            //       height: 60,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         shape: BoxShape.circle,
            //         border: Border.all(
            //           color: const Color(0xFFE65100), // Dark orange border
            //           width: 2,
            //         ),
            //       ),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(30),
            //         child: Image.asset(
            //           'assets/images/pending.png',
            //           width: 60,
            //           height: 60,
            //           fit: BoxFit.cover,
            //           errorBuilder: (context, error, stackTrace) {
            //             return const Icon(
            //               Icons.warning,
            //               color: Color(0xFFE65100), // Dark orange icon
            //               size: 32,
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/pending.png',
                width: 150,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.warning,
                    color: Color(0xFFE65100), // Dark orange icon
                    size: 32,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            
            // Title
            AppText(
              "Please wait for the provider's confirmation",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.Black,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Description
            AppText(
              "If not confirmed within $timeLimit minutes, the request will be automatically cancelled, and you will be eligible to contact another provider for the same issue.",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.DarkGray,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Okay button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3934F), // Updated button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: AppText(
                  "Okay",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
