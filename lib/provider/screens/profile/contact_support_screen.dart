import 'package:flutter/material.dart';
import 'thank_you_screen.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _selectedIssue = "";

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
          "Contact Support",
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
            // Issue Selection Dropdown
            _buildIssueDropdown(),
            const SizedBox(height: 20),

            // Email Composition Area
            _buildEmailCompositionArea(),
            const SizedBox(height: 20),

            // Send Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThankYouScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7A60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Send",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select one Issue",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: _selectedIssue.isEmpty ? null : _selectedIssue,
            decoration: InputDecoration(
              hintText: "Select one Issue",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF0E7A60)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: "General Inquiry", 
                child: Text("General Inquiry", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Account Help", 
                child: Text("Account Help", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Billing & Payments", 
                child: Text("Billing & Payments", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Technical Support (App/Website Issues)", 
                child: Text("Technical Support (App/Website Issues)", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Service Provider Verification", 
                child: Text("Service Provider Verification", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Report a Problem with a Service Provider", 
                child: Text("Report a Problem with a Service Provider", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Report a Problem with a Customer", 
                child: Text("Report a Problem with a Customer", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Scheduling or Booking Issues", 
                child: Text("Scheduling or Booking Issues", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Feedback & Suggestions", 
                child: Text("Feedback & Suggestions", overflow: TextOverflow.ellipsis),
              ),
              DropdownMenuItem(
                value: "Other", 
                child: Text("Other", overflow: TextOverflow.ellipsis),
              ),
            ],
            onChanged: (value) => setState(() => _selectedIssue = value ?? ""),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailCompositionArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Compose email",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: TextField(
            controller: _emailController,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: "Compose email",
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
