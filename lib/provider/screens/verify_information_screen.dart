import 'package:flutter/material.dart';
import 'package:naibrly/provider/screens/select_service_area_screen.dart';
import '../widgets/button.dart';
import '../widgets/colors.dart';
import '../widgets/dropdown.dart';
import '../widgets/textfield.dart';
import '../widgets/upload_card.dart';
import '../widgets/custom_single_select_dropdown.dart';

class VerifyInformationScreen extends StatefulWidget {
  const VerifyInformationScreen({super.key});

  @override
  State<VerifyInformationScreen> createState() => _VerifyInformationScreenState();
}

class _VerifyInformationScreenState extends State<VerifyInformationScreen> {
  final TextEditingController einController = TextEditingController();
  final TextEditingController ownerFirstNameController =
  TextEditingController(text: "Mina");
  final TextEditingController ownerLastNameController =
  TextEditingController(text: "Leo");

  String? selectedState;
  bool isDifferentOwner = true;
  
  final List<String> usStates = [
    "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado",
    "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho",
    "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
    "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota",
    "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada",
    "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina",
    "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
    "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas",
    "Utah", "Vermont", "Virginia", "Washington", "West Virginia",
    "Wisconsin", "Wyoming"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KoreColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verify Your Information",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "We need to verify your business details.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // EIN Number
            KoreTextField(
              label: "EIN Number",
              hint: "Enter your 9-digit EIN (e.g., 12-3456789)",
              controller: einController,
            ),
            const SizedBox(height: 8),
            const Text(
              "An Employer Identification Number (EIN) is a federal tax ID for businesses",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 20),

            // Business Registered In
            const Text(
              "Business is registered in",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            CustomSingleSelectDropdown(
              hint: "Select USA state",
              items: usStates,
              selectedItem: selectedState,
              onChanged: (value) {
                setState(() {
                  selectedState = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Upload Proof of Insurance
            const Text(
              "Upload proof of insurance coverage",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const KoreUploadCard(
              label: "Upload proof of insurance coverage",
              hint: "Acceptable formats: JPG, PNG, PDF (Max 10MB)",
              icon: Icons.cloud_upload_outlined,
            ),
            const SizedBox(height: 20),

            // Checkbox for different owner/operator
            Row(
              children: [
                Checkbox(
                  value: isDifferentOwner,
                  onChanged: (val) =>
                      setState(() => isDifferentOwner = val ?? false),
                  activeColor: KoreColors.primary,
                ),
                const Expanded(
                  child: Text(
                    "Information of the Registered Owner/Operator is different than you",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),

            if (isDifferentOwner) ...[
              const SizedBox(height: 10),
              KoreTextField(
                label: "Owner Operator: First Name",
                hint: "Enter first name",
                controller: ownerFirstNameController,
              ),
              const SizedBox(height: 12),
              KoreTextField(
                label: "Owner Operator: Last Name",
                hint: "Enter last name",
                controller: ownerLastNameController,
              ),
              const SizedBox(height: 20),

              const Text(
                "Owner Operator ID check",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Front",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/Textfields.png',
                      height: 195,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Back",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/Textfields.png',
                      height: 195,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

            ],

            const SizedBox(height: 40),

            KoreButton(
              text: "Next",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectServiceAreaScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
