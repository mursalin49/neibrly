import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../base/AppText/appText.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.White,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.Black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const AppText(
          "Privacy Policy",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.Black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              "Last Updated: January 2024",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.DarkGray,
            ),
            const SizedBox(height: 20),
            
            _buildSection(
              "Information We Collect",
              "We collect information you provide directly to us, such as when you create an account, use our services, or contact us for support.",
            ),
            
            _buildSection(
              "How We Use Your Information",
              "We use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.",
            ),
            
            _buildSection(
              "Information Sharing",
              "We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.",
            ),
            
            _buildSection(
              "Data Security",
              "We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.",
            ),
            
            _buildSection(
              "Your Rights",
              "You have the right to access, update, or delete your personal information. You may also opt out of certain communications from us.",
            ),
            
            _buildSection(
              "Contact Us",
              "If you have any questions about this Privacy Policy, please contact us at privacy@naibrly.com",
            ),
            
            const SizedBox(height: 30),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.LightGray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.LightGray),
              ),
              child: const AppText(
                "By using our services, you agree to the collection and use of information in accordance with this policy.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.DarkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.Black,
          ),
          const SizedBox(height: 8),
          AppText(
            content,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.DarkGray,
          ),
        ],
      ),
    );
  }
}
