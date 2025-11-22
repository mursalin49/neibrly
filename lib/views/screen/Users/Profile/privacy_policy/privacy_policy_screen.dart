
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../base/AppText/appText.dart';


class PrivacyPolicyScreen extends StatelessWidget{
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
        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/icon/arrow-left.svg",
            color: Colors.black,
            width: 24,
            height: 24,
          ),
        ),

        title: AppText(
          "Privacy policy",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and content sections
            _buildSection(
              title: "Information We Collect",
              content:
              "We collect personal information such as your name, email, phone number, and account details when you register or interact with Job Pilot. We also collect usage data like job applications, saved preferences, and device information to improve your experience.",
            ),
            _buildSection(
              title: "How We Use Your Data",
              content:
              "We use your information to help you track job applications, schedule interviews, send notifications, and enhance overall app performance. This also allows us to provide better recommendations and maintain secure communication with you.",
            ),
            _buildSection(
              title: "Data Sharing & Security",
              content:
              "We do not sell your data. However, we may share limited information with third-party services (e.g., analytics or cloud storage) strictly to improve Job Pilot's features. We implement security measures to protect your data from unauthorized access.",
            ),
            _buildSection(
              title: "User Rights",
              content:
              "You have the right to view, edit, or delete your personal information stored on Job Pilot. You can also choose to deactivate your account or opt-out of notifications at any time. For any privacy-related concerns, contact our support team.",
            ),
            _buildSection(
              title: "Contact Info",
              content:
              "For questions about this privacy policy or how we handle your data, please reach out to us at:\nsupport@jobpilot.com",
            ),

          ],
        ),
      ),
    );
  }


  // Helper method to build each section
  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          SizedBox(height: 8),
          AppText(
            content,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

}
