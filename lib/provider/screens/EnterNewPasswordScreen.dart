import 'package:flutter/material.dart';

import 'Payout.dart';

class EnterNewPasswordScreen extends StatefulWidget {
  const EnterNewPasswordScreen({super.key});

  @override
  State<EnterNewPasswordScreen> createState() => _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState extends State<EnterNewPasswordScreen> {
  bool passwordVisible = false;
  bool retypeVisible = false;

  final TextEditingController passwordController =
  TextEditingController(text: "AbcD@7281");
  final TextEditingController retypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Enter New Password",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Set Complex passwords to protect",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 30),

            // Password Field
            TextField(
              controller: passwordController,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Retype Password Field
            TextField(
              controller: retypeController,
              obscureText: !retypeVisible,
              decoration: InputDecoration(
                hintText: "Retype Password",
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    retypeVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      retypeVisible = !retypeVisible;
                    });
                  },
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E7B60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayoutInformationScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Set New Password",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const Spacer(),

            // Footer text
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Need Help",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 13,
                        ),
                      ),
                      const TextSpan(text: " | "),
                      TextSpan(
                        text: "FAQ",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 13,
                        ),
                      ),
                      const TextSpan(text: " | "),
                      TextSpan(
                        text: "Terms Of use",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
