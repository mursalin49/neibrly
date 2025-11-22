import 'package:flutter/material.dart';
import '../../widgets/custom_single_select_dropdown.dart';

class UpdateInformationScreen extends StatefulWidget {
  const UpdateInformationScreen({super.key});

  @override
  State<UpdateInformationScreen> createState() => _UpdateInformationScreenState();
}

class _UpdateInformationScreenState extends State<UpdateInformationScreen> {
  final TextEditingController _businessNameRegisteredController = TextEditingController(text: "Jacob Meikle");
  final TextEditingController _businessNameDBAController = TextEditingController(text: "Jacob Meikle");
  final TextEditingController _addressController = TextEditingController(text: "123 Oak Street Springfield, IL 62704");
  final TextEditingController _phoneController = TextEditingController(text: "(239) 555-0108");
  final TextEditingController _websiteController = TextEditingController();

  String _selectedRole = "";
  String _selectedStartDay = "Mon";
  String _selectedEndDay = "Fri";
  String _selectedStartTime = "9:00 am";
  String _selectedEndTime = "5:00 pm";
  String _selectedCountryCode = "1+";

  @override
  void dispose() {
    _businessNameRegisteredController.dispose();
    _businessNameDBAController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Confirm your info",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  "Make sure your personal information is correct. For legal purposes, you will be unable to edit your legal name once it's submitted.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),

                // Information List
                _buildInfoItem("LEGAL FULL NAME:", _businessNameRegisteredController.text),
                _buildInfoItem("EIN Number:", "855-46-3109"),
                _buildInfoItem("Business is registered in:", "USA state"),
                _buildInfoItem("Business Hours:", "$_selectedStartTime - $_selectedEndTime"),
                _buildInfoItem("Business ADDRESS:", _addressController.text),
                
                const SizedBox(height: 12),
                const Text(
                  "Services Provided:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    ServiceTag(
                      "Home Repairs & Maintenance",
                      color: Color(0xFFFFE4B5),
                      dotColor: Color(0xFFFF8C00),
                    ),
                    ServiceTag(
                      "Cleaning & Organization",
                      color: Color(0xFFFFFACD),
                      dotColor: Color(0xFFFFD700),
                    ),
                    ServiceTag(
                      "Renovations & Upgrades",
                      color: Color(0xFFFFB6C1),
                      dotColor: Color(0xFFFF1493),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Additional info
                Text(
                  "Once you confirm, you will be taken to a secure identity check. This will only take a few minutes",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF0E7A60)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            color: Color(0xFF0E7A60),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          Navigator.of(context).pop(); // Go back to Profile
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0E7A60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
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
           "Update Your Information",
           style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: 16,
           ),
         ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUploadSection(),
            const SizedBox(height: 24),

            _buildTextField(
              label: "Business Name (AS REGISTERED)",
              controller: _businessNameRegisteredController,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              label: "Business Name (DBA)",
              controller: _businessNameDBAController,
            ),
            const SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select your role",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                CustomSingleSelectDropdown(
                  hint: "Select your role",
                  items: const ["Owner", "Manager", "Employee"],
                  selectedItem: _selectedRole.isEmpty ? null : _selectedRole,
                  onChanged: (value) => setState(() => _selectedRole = value ?? ""),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildTextField(
              label: "Address",
              controller: _addressController,
              readOnly: true,
            ),
            const SizedBox(height: 16),

            _buildPhoneNumberFields(),
            const SizedBox(height: 16),

            _buildTextField(
              label: "Business Website",
              controller: _websiteController,
              hintText: "Business Website",
            ),
            const SizedBox(height: 24),

            _buildServiceDaysSection(),
            const SizedBox(height: 16),

            _buildBusinessHoursSection(),
            const SizedBox(height: 24),

            _buildServicesSection(),
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xFF0E7A60),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                   padding: const EdgeInsets.symmetric(vertical: 16),
                 ),
                 child: const Text(
                   "Update",
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

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text(
           "Upload Business Logo",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 14,
           ),
         ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.upload_file,
                size: 40,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 8),
               Text(
                 "Upload Your Business Logo",
                 style: TextStyle(
                   color: Colors.grey.shade600,
                   fontSize: 12,
                 ),
               ),
               const SizedBox(height: 4),
               Text(
                 "Max 3 MB",
                 style: TextStyle(
                   color: Colors.grey.shade500,
                   fontSize: 10,
                 ),
               ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
           style: const TextStyle(
             fontWeight: FontWeight.w600,
             fontSize: 12,
           ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
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
              borderSide: const BorderSide(color: Color(0xFF2D5A87)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
           style: const TextStyle(
             fontWeight: FontWeight.w600,
             fontSize: 12,
           ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value.isEmpty ? null : value,
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
              borderSide: const BorderSide(color: Color(0xFF2D5A87)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          hint: Text(label),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPhoneNumberFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text(
           "Phone Number",
           style: TextStyle(
             fontWeight: FontWeight.w600,
             fontSize: 12,
           ),
         ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                value: _selectedCountryCode,
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
                    borderSide: const BorderSide(color: Color(0xFF2D5A87)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: "1+", child: Text("1+")),
                  DropdownMenuItem(value: "44+", child: Text("44+")),
                  DropdownMenuItem(value: "91+", child: Text("91+")),
                ],
                onChanged: (value) => setState(() => _selectedCountryCode = value ?? "1+"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: TextField(
                controller: _phoneController,
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
                    borderSide: const BorderSide(color: Color(0xFF2D5A87)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceDaysSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text(
           "Business Service Days",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 14,
           ),
         ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedStartDay,
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
                    borderSide: const BorderSide(color: Color(0xFF2D5A87)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: "Mon", child: Text("Mon")),
                  DropdownMenuItem(value: "Tue", child: Text("Tue")),
                  DropdownMenuItem(value: "Wed", child: Text("Wed")),
                  DropdownMenuItem(value: "Thu", child: Text("Thu")),
                  DropdownMenuItem(value: "Fri", child: Text("Fri")),
                  DropdownMenuItem(value: "Sat", child: Text("Sat")),
                  DropdownMenuItem(value: "Sun", child: Text("Sun")),
                ],
                onChanged: (value) => setState(() => _selectedStartDay = value ?? "Mon"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("to"),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedEndDay,
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
                    borderSide: const BorderSide(color: Color(0xFF2D5A87)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: "Mon", child: Text("Mon")),
                  DropdownMenuItem(value: "Tue", child: Text("Tue")),
                  DropdownMenuItem(value: "Wed", child: Text("Wed")),
                  DropdownMenuItem(value: "Thu", child: Text("Thu")),
                  DropdownMenuItem(value: "Fri", child: Text("Fri")),
                  DropdownMenuItem(value: "Sat", child: Text("Sat")),
                  DropdownMenuItem(value: "Sun", child: Text("Sun")),
                ],
                onChanged: (value) => setState(() => _selectedEndDay = value ?? "Fri"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessHoursSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text(
           "Business Hours",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 14,
           ),
         ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedStartTime,
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
                    borderSide: const BorderSide(color: Color(0xFF2D5A87)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: "9:00 am", child: Text("9:00 am")),
                  DropdownMenuItem(value: "10:00 am", child: Text("10:00 am")),
                  DropdownMenuItem(value: "11:00 am", child: Text("11:00 am")),
                  DropdownMenuItem(value: "12:00 pm", child: Text("12:00 pm")),
                ],
                onChanged: (value) => setState(() => _selectedStartTime = value ?? "9:00 am"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("to"),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedEndTime,
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
                    borderSide: const BorderSide(color: Color(0xFF2D5A87)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: "5:00 pm", child: Text("5:00 pm")),
                  DropdownMenuItem(value: "6:00 pm", child: Text("6:00 pm")),
                  DropdownMenuItem(value: "7:00 pm", child: Text("7:00 pm")),
                  DropdownMenuItem(value: "8:00 pm", child: Text("8:00 pm")),
                ],
                onChanged: (value) => setState(() => _selectedEndTime = value ?? "5:00 pm"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text(
           "Services Provided",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 14,
           ),
         ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: "Select services",
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
              borderSide: const BorderSide(color: Color(0xFF2D5A87)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(value: "home_repairs", child: Text("Home Repairs & Maintenance")),
            DropdownMenuItem(value: "cleaning", child: Text("Cleaning & Organization")),
            DropdownMenuItem(value: "renovations", child: Text("Renovations & Upgrades")),
          ],
          onChanged: (value) {},
        ),
        // const SizedBox(height: 12),
        // Wrap(
        //   spacing: 8,
        //   runSpacing: 8,
        //   children: const [
        //     ServiceTag(
        //       "Home Repairs & Maintenance",
        //       color: Color(0xFFFFE4B5),
        //       dotColor: Color(0xFFFF8C00),
        //     ),
        //     ServiceTag(
        //       "Cleaning & Organization",
        //       color: Color(0xFFFFFACD),
        //       dotColor: Color(0xFFFFD700),
        //     ),
        //     ServiceTag(
        //       "Renovations & Upgrades",
        //       color: Color(0xFFFFB6C1),
        //       dotColor: Color(0xFFFF1493),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class ServiceTag extends StatelessWidget {
  final String text;
  final Color color;
  final Color dotColor;

  const ServiceTag(
    this.text, {
    super.key,
    required this.color,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
           Text(
             text,
             style: const TextStyle(
               fontSize: 10,
               fontWeight: FontWeight.w500,
             ),
           ),
        ],
      ),
    );
  }
}
