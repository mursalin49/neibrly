import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../base/AppText/appText.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

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
          "Terms & Conditions",
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
              "Acceptance of Terms",
              "By accessing and using Naibrly services, you accept and agree to be bound by the terms and provision of this agreement.",
            ),
            
            _buildSection(
              "Service Description",
              "Naibrly provides a platform connecting homeowners with service providers for various home maintenance and repair services.",
            ),
            
            _buildSection(
              "User Responsibilities",
              "Users are responsible for providing accurate information, maintaining account security, and complying with all applicable laws and regulations.",
            ),
            
            _buildSection(
              "Service Provider Responsibilities",
              "Service providers must maintain proper licensing, provide quality services, and adhere to safety standards and professional conduct.",
            ),
            
            _buildSection(
              "Payment Terms",
              "Payment terms vary by service. Users agree to pay all applicable fees and charges as described in the service agreement.",
            ),
            
            _buildSection(
              "Cancellation Policy",
              "Cancellation policies vary by service provider. Users should review cancellation terms before booking services.",
            ),
            
            _buildSection(
              "Limitation of Liability",
              "Naibrly's liability is limited to the maximum extent permitted by law. We are not responsible for damages arising from service provider actions.",
            ),
            
            _buildSection(
              "Dispute Resolution",
              "Disputes will be resolved through binding arbitration in accordance with the rules of the American Arbitration Association.",
            ),
            
            _buildSection(
              "Modifications",
              "We reserve the right to modify these terms at any time. Continued use of the service constitutes acceptance of modified terms.",
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
                "By using Naibrly services, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.",
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
