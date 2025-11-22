import 'package:flutter/material.dart';
import '../../screens/profile/contact_support_screen.dart';
import '../../screens/profile/payment_history_screen.dart';
import '../../screens/profile/terms_conditions_screen.dart';
import '../../screens/profile/privacy_policy_screen.dart';
import '../../screens/profile/faq_screen.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.grey),
        
        _buildSettingItem(context, "Help & Support", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FAQScreen(),
            ),
          );
        }),
        const Divider(color: Colors.grey),
        _buildSettingItem(context, "Privacy Policy", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrivacyPolicyScreen(),
            ),
          );
        }),
        const Divider(color: Colors.grey),
        _buildSettingItem(context, "Terms & Condition", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsConditionsScreen(),
            ),
          );
        }),
        const Divider(color: Colors.grey),
        _buildSettingItem(context, "Payment History", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentHistoryScreen(),
            ),
          );
        }),
        const Divider(color: Colors.grey),
        const SizedBox(height: 10),
        Text(
          "Logout",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, [VoidCallback? onTap]) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}
