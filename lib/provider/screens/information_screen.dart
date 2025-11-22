import 'package:flutter/material.dart';
import 'package:naibrly/provider/screens/verify_information_screen.dart';
import '../widgets/button.dart';
import '../widgets/colors.dart';
import '../widgets/textfield.dart';
import '../widgets/upload_card.dart';
import '../widgets/business_hours_bottom_sheet.dart';
import '../widgets/custom_multi_select_dropdown.dart';
import '../widgets/custom_single_select_dropdown.dart';

class YourInformationScreen extends StatefulWidget {
  const YourInformationScreen({super.key});

  @override
  State<YourInformationScreen> createState() => _YourInformationScreenState();
}

class _YourInformationScreenState extends State<YourInformationScreen> {
  String selectedCountryCode = "+1";
  String selectedStartDay = "Mon";
  String selectedEndDay = "Fri";
  String selectedStartTime = "9:00 am";
  String selectedEndTime = "5:00 pm";
  String? selectedRole;
  final List<String> roleOptions = ["Owner", "Manager", "Operator"];
  List<String> selectedServices = [];
  final List<String> availableServices = [
    "Home Repairs & Maintenance",
    "Cleaning & Organization",
    "Renovations & Upgrades",
    "Electrical Services",
    "Plumbing Services",
    "HVAC Services",
  ];

  final TextEditingController hourlyRateController = TextEditingController(text: "10");

  // Business hours state - all days closed by default
  List<DayHours> businessHours = [
    DayHours(dayName: "Sunday", isOpen: false),
    DayHours(dayName: "Monday", isOpen: false),
    DayHours(dayName: "Tuesday", isOpen: false),
    DayHours(dayName: "Wednesday", isOpen: false),
    DayHours(dayName: "Thursday", isOpen: false),
    DayHours(dayName: "Friday", isOpen: false),
    DayHours(dayName: "Saturday", isOpen: false),
  ];

  @override
  void dispose() {
    hourlyRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KoreColors.background,
      appBar: AppBar(
        backgroundColor: KoreColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Your Information",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtext
              const Text(
                "We need to collect your personal business information.",
                style: TextStyle(
                  color: Color(0xFF1C1C1C),
                  fontSize: 13,
                ),
                textAlign: TextAlign.start,
              ),

              const SizedBox(height: 20),

              // Upload Business Logo
              const Text(
                "Upload Business Logo",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const KoreUploadCard(
                label: "Upload Your Business Logo",
                hint: "Max 3 MB",
                icon: Icons.cloud_upload_outlined,
              ),
              const SizedBox(height: 24),

              // Business Name (Registered)
              const KoreTextField(
                label: "Business Name (AS REGISTERED)",
                hint: "e.g., JM Home Services LLC",
              ),
              const SizedBox(height: 16),

              // Business Name (DBA)
              const KoreTextField(
                label: "Business Name (DBA)",
                hint: "e.g., JM Home Services",
              ),
              const SizedBox(height: 16),

              // Registrant First and Last Name
              const KoreTextField(
                label: "First Name",
                hint: "Jacob",
              ),
              const SizedBox(height: 16),
              const KoreTextField(
                label: "Last Name",
                hint: "Meikle",
              ),
              const SizedBox(height: 16),
              const KoreTextField(
                label: "Email Address",
                hint: "Jhon@gmail.com",
              ),
              const SizedBox(height: 16),
              const KoreTextField(
                label: "Password",
                hint: "Jhon@gmail.com",
              ),
              const SizedBox(height: 16),
              const KoreTextField(
                label: "Confirm Password",
                hint: "Jhon@gmail.com",
              ),
              const SizedBox(height: 16),
              // Role dropdown
              const Text(
                "Role",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              CustomSingleSelectDropdown(
                hint: "Select your role",
                items: roleOptions,
                selectedItem: selectedRole,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Business Address
              TextField(
                decoration: InputDecoration(
                  hintText: "Business Address",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF0E7A60)),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Phone number row
              Row(
                children: [
                  // Country code dropdown
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCountryCode,
                        isDense: true,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: "+1", child: Text("+1")),
                          DropdownMenuItem(value: "+44", child: Text("+44")),
                          DropdownMenuItem(value: "+91", child: Text("+91")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCountryCode = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Phone number input
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF0E7A60)),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Business Website
              TextField(
                decoration: InputDecoration(
                  hintText: "Business Website",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF0E7A60)),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Business Hours
              const Text(
                "Business Hours",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  _showBusinessHoursBottomSheet();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Set Your Business Hours",
                              style: TextStyle(
                                color: Color(0xFF1C1C1C),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getBusinessHoursSummary(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey.shade400),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Services Provided
              const Text(
                "Services Provided",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              CustomMultiSelectDropdown(
                hint: "Select Services",
                items: availableServices,
                selectedItems: selectedServices,
                onChanged: (selected) {
                  setState(() {
                    selectedServices = selected;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Hourly Rate Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0E7A60).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF0E7A60), width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0E7A60),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Enter Your Hourly Rate",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        "Set how much you charge per hour",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1C1C1C),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                "\$",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF888888),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: hourlyRateController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "10",
                                hintStyle: TextStyle(
                                  color: Color(0xFF888888),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1C1C1C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: KoreButton(
            text: "Next",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VerifyInformationScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Helper dropdown builder
  Widget _buildDropdown(List<String> items, String value, Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        isExpanded: true,
        value: value,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _showBusinessHoursBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BusinessHoursBottomSheet(
        initialHours: businessHours,
        onSave: (hours) {
          setState(() {
            businessHours = hours;
          });
        },
      ),
    );
  }

  String _getBusinessHoursSummary() {
    final openDays = businessHours.where((day) => day.isOpen).toList();
    if (openDays.isEmpty) {
      return "No hours set";
    }

    // Get the first and last open days
    final firstDay = openDays.first.dayName.substring(0, 3);
    final lastDay = openDays.last.dayName.substring(0, 3);

    // Check if all open days have the same hours
    final sampleTime = "${_formatTime(openDays.first.startTime)} - ${_formatTime(openDays.first.endTime)}";
    bool allSameHours = openDays.every((day) =>
    day.startTime.hour == openDays.first.startTime.hour &&
        day.startTime.minute == openDays.first.startTime.minute &&
        day.endTime.hour == openDays.first.endTime.hour &&
        day.endTime.minute == openDays.first.endTime.minute
    );

    if (allSameHours && openDays.length == 7 - businessHours.where((day) => !day.isOpen).length) {
      return "$firstDay - $lastDay • $sampleTime";
    }

    return "${openDays.length} days configured";
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}


class ServiceTag extends StatelessWidget {
  final String text;
  final Color dotColor;
  final Color backgroundColor;

  const ServiceTag({
    super.key,
    required this.text,
    required this.dotColor,
    required this.backgroundColor, required Color textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: dotColor, size: 8),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}