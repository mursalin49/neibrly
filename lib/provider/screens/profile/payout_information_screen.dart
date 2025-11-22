import 'package:flutter/material.dart';

class PayoutInformationScreen extends StatefulWidget {
  const PayoutInformationScreen({super.key});

  @override
  State<PayoutInformationScreen> createState() => _PayoutInformationScreenState();
}

class _PayoutInformationScreenState extends State<PayoutInformationScreen> {
  final TextEditingController _accountHolderController = TextEditingController(text: "Jacob Meikle");
  final TextEditingController _accountNumberController = TextEditingController(text: "0123456789");
  final TextEditingController _routingNumberController = TextEditingController(text: "0123456789");

  String _selectedBank = "";

  @override
  void dispose() {
    _accountHolderController.dispose();
    _accountNumberController.dispose();
    _routingNumberController.dispose();
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
          "Payout Information",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              // Handle refresh action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Update payout information.",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              "Updating banking information requires admin approval.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            _buildTextField(
              label: "Account Holder Name",
              controller: _accountHolderController,
            ),
            const SizedBox(height: 20),

            _buildBankDropdown(),
            const SizedBox(height: 20),

            _buildTextField(
              label: "Enter Your Bank Account Number",
              controller: _accountNumberController,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              label: "Routing Number",
              controller: _routingNumberController,
            ),
            const SizedBox(height: 32),

            _buildSecurityBox(),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7A60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Update Request",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
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
          ),
        ),
      ],
    );
  }

  Widget _buildBankDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bank Name",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedBank.isEmpty ? null : _selectedBank,
          decoration: InputDecoration(
            hintText: "Choose your bank",
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
          ),
          items: const [
            DropdownMenuItem(value: "Bank of America", child: Text("Bank of America")),
            DropdownMenuItem(value: "JPMorgan Chase", child: Text("JPMorgan Chase")),
            DropdownMenuItem(value: "Wells Fargo", child: Text("Wells Fargo")),
            DropdownMenuItem(value: "Citibank", child: Text("Citibank")),
            DropdownMenuItem(value: "US Bank", child: Text("US Bank")),
            DropdownMenuItem(value: "PNC Bank", child: Text("PNC Bank")),
            DropdownMenuItem(value: "Capital One", child: Text("Capital One")),
            DropdownMenuItem(value: "TD Bank", child: Text("TD Bank")),
            DropdownMenuItem(value: "Bank of New York Mellon", child: Text("Bank of New York Mellon")),
            DropdownMenuItem(value: "State Street Bank", child: Text("State Street Bank")),
            DropdownMenuItem(value: "Goldman Sachs", child: Text("Goldman Sachs")),
            DropdownMenuItem(value: "Morgan Stanley", child: Text("Morgan Stanley")),
            DropdownMenuItem(value: "American Express", child: Text("American Express")),
            DropdownMenuItem(value: "Discover Bank", child: Text("Discover Bank")),
            DropdownMenuItem(value: "Ally Bank", child: Text("Ally Bank")),
            DropdownMenuItem(value: "Charles Schwab Bank", child: Text("Charles Schwab Bank")),
            DropdownMenuItem(value: "Fifth Third Bank", child: Text("Fifth Third Bank")),
            DropdownMenuItem(value: "KeyBank", child: Text("KeyBank")),
            DropdownMenuItem(value: "Regions Bank", child: Text("Regions Bank")),
            DropdownMenuItem(value: "SunTrust Bank", child: Text("SunTrust Bank")),
            DropdownMenuItem(value: "BB&T Bank", child: Text("BB&T Bank")),
            DropdownMenuItem(value: "Huntington Bank", child: Text("Huntington Bank")),
            DropdownMenuItem(value: "Comerica Bank", child: Text("Comerica Bank")),
            DropdownMenuItem(value: "M&T Bank", child: Text("M&T Bank")),
            DropdownMenuItem(value: "First National Bank", child: Text("First National Bank")),
            DropdownMenuItem(value: "Other", child: Text("Other")),
          ],
          onChanged: (value) => setState(() => _selectedBank = value ?? ""),
        ),
      ],
    );
  }

  Widget _buildSecurityBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.people,
              color: Color(0xFF4CAF50),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your information is secure.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "We use bank-level encryption and Stripe to protect your payment information.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
