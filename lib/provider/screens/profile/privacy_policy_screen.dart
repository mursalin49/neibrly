import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              "Information We Collect",
              "We collect personal information such as your name, email address, phone number, and profile details when you create an account or use our services. We also gather usage data including app interactions, preferences, and device information to enhance your experience and improve our services.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "How We Use Your Information",
              "Your information is used to provide personalized services, send important notifications, improve app functionality, and maintain secure communication. We analyze usage patterns to offer better recommendations and ensure optimal performance of our platform.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "Data Protection & Security",
              "We implement industry-standard security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. Your data is encrypted during transmission and stored securely using advanced encryption technologies.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "Information Sharing",
              "We do not sell, trade, or rent your personal information to third parties. We may share limited data with trusted service providers who assist us in operating our platform, conducting business, or serving users, provided they agree to keep this information confidential.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "Your Privacy Rights",
              "You have the right to access, update, or delete your personal information at any time. You can modify your privacy settings, opt-out of certain communications, or request data portability. Contact our support team for assistance with any privacy-related requests.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "Cookies & Tracking",
              "We use cookies and similar tracking technologies to enhance your browsing experience, analyze app usage, and provide personalized content. You can control cookie preferences through your device settings, though some features may not function properly if cookies are disabled.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "Data Retention",
              "We retain your personal information only as long as necessary to fulfill the purposes outlined in this privacy policy, comply with legal obligations, resolve disputes, and enforce our agreements. When data is no longer needed, we securely delete or anonymize it.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "Contact Information",
              "If you have any questions, concerns, or requests regarding this privacy policy or our data practices, please contact our privacy team at privacy@jobpilot.com or through our in-app support system. We are committed to addressing your privacy concerns promptly and transparently.",
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
