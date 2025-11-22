import 'package:flutter/material.dart';
import 'package:naibrly/provider/screens/reset_password_screen.dart';
import '../widgets/button.dart';
import '../widgets/colors.dart';


class ConfirmInfoScreen extends StatelessWidget {
  const ConfirmInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KoreColors.background,
      appBar: AppBar(title: const Text("Confirm Your Info")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Make sure your personal information is correct. For legal purposes, "
                  "you will be unable to edit your legal name once it’s submitted.",
              style: TextStyle(fontSize: 14, color: KoreColors.textDark),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: KoreColors.border),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("LEGAL FULL NAME:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Jacob Meikle"),
                      SizedBox(height: 12),
                      Text("Your role:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Owner"),
                      SizedBox(height: 12),
                      Text("Business Address:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("17 W 47th St, b4 New York, NY 10036"),
                      SizedBox(height: 12),
                      Text("Phone Number:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("239-555-0108"),
                      SizedBox(height: 12),
                      Text("Business registered in:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("USA state"),
                      SizedBox(height: 12),
                      Text("EIN Number:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("855-46-3109"),
                      SizedBox(height: 12),
                      Text("Services Provided:", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [

                          Chip(
                            backgroundColor: KoreColors.lightOrange,
                            avatar: const Icon(
                              Icons.circle_outlined,
                              color: KoreColors.orange, // orange tone for icon
                              size: 12,
                            ),
                            label: const Text(
                              "Home Repairs & Maintenance",
                              style: TextStyle(
                                color: KoreColors.orange, // text same as icon
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                          ),
                          Chip(
                            backgroundColor: KoreColors.lightYello,
                            avatar: const Icon(
                              Icons.circle_outlined,
                              color: KoreColors.yello, // orange tone for icon
                              size: 12,
                            ),
                            label: const Text(
                              "Cleaning & Organization",
                              style: TextStyle(
                                color: KoreColors.yello, // text same as icon
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                          ),
                          Chip(
                            backgroundColor: KoreColors.lightRed,
                            avatar: const Icon(
                              Icons.circle_outlined,
                              color: KoreColors.red, // orange tone for icon
                              size: 12,
                            ),
                            label: const Text(
                              "Renovations & Upgrades",
                              style: TextStyle(
                                color: KoreColors.red, // text same as icon
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                          ),

                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Once you confirm, you will be taken to a secure identity check. "
                            "This will only take a few minutes.",
                        style: TextStyle(fontSize: 13, color: KoreColors.textDark),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: KoreButton(
                    text: "Edit",
                    isPrimary: false,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: KoreButton(
                    text: "Next",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
