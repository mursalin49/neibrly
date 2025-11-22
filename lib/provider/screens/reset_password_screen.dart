import 'package:flutter/material.dart';
import '../widgets/colors.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';
import 'otp_verification_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController =
  TextEditingController(text: "Jhon@gmail.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KoreColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reset Your Password",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter your email address below and we’ll send you a link with instructions",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 30),

            // Center image
            Center(
              child: Image.asset(
                "assets/images/Group 513789.png", // add your image asset
                height: 180,
              ),
            ),
            const SizedBox(height: 30),

            // Email input field
            KoreTextField(
              label: "Email Address",
              hint: "Enter your email",
              controller: emailController,
            ),
            const SizedBox(height: 30),

            // Send Verification Code Button
            KoreButton(
              text: "Send Verification Code",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthenticationCodeScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),

            // Footer links
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Need Help ",
                  style: const TextStyle(color: Colors.black54),
                  children: [
                    const TextSpan(text: "| "),
                    TextSpan(
                      text: "FAQ ",
                      style: TextStyle(color: KoreColors.primary),
                    ),
                    const TextSpan(text: "| "),
                    TextSpan(
                      text: "Terms Of Use",
                      style: TextStyle(color: KoreColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
