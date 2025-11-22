import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
          "Terms & Conditions",
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
              "We collect personal information such as your name, email, phone number, and account details when you register or interact with Job Pilot. We also collect usage data like job applications, saved preferences, and device information to improve your experience.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "How We Use Your Data",
              "We use your information to help you track job applications, schedule interviews, send notifications, and enhance overall app performance. This also allows us to provide better recommendations and maintain secure communication with you.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "Data Sharing & Security",
              "We do not sell your data. However, we may share limited information with third-party services (e.g., analytics or cloud storage) strictly to improve Job Pilot's features. We implement security measures to protect your data from unauthorized access.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "User Rights",
              "You have the right to view, edit, or delete your personal information stored on Job Pilot. You can also choose to deactivate your account or opt-out of notifications at any time. For any privacy-related concerns, contact our support team.",
            ),
            const SizedBox(height: 24),

            _buildSection(
              "Contact Info",
              "For questions about this privacy policy or how we handle your data, please contact our support team through the app or email us at support@jobpilot.com. We're committed to addressing your concerns promptly.",
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
