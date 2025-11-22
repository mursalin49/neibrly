import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// DayHours ক্লাসের ডেফিনিশন
class DayHours {
  final String dayName;
  bool isOpen;
  TimeOfDay startTime;
  TimeOfDay endTime;

  DayHours({
    required this.dayName,
    required this.isOpen,
    this.startTime = const TimeOfDay(hour: 9, minute: 0),
    this.endTime = const TimeOfDay(hour: 17, minute: 0),
  });

  DayHours copyWith({bool? isOpen, TimeOfDay? startTime, TimeOfDay? endTime}) {
    return DayHours(
      dayName: dayName,
      isOpen: isOpen ?? this.isOpen,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}


class YourInfoController extends GetxController {
  // 🔑 API Base URL (আপনার প্রকৃত API Endpoint এখানে দিন)
  final String _baseUrl = "https://api.yourdomain.com/v1";

  // --- A. Text Controllers ---
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController businessNameRegisteredController = TextEditingController();
  final TextEditingController businessNameDbaController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController businessWebsiteController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController(text: "10");

  // --- B. GetX Reactive States (Rx) ---
  final RxString selectedCountryCode = '+1'.obs;
  final RxnString selectedRole = RxnString(null);
  final RxList<String> selectedServices = <String>[].obs;

  final RxList<DayHours> businessHours = <DayHours>[
    DayHours(dayName: "Sunday", isOpen: false),
    DayHours(dayName: "Monday", isOpen: false),
    DayHours(dayName: "Tuesday", isOpen: false),
    DayHours(dayName: "Wednesday", isOpen: false),
    DayHours(dayName: "Thursday", isOpen: false),
    DayHours(dayName: "Friday", isOpen: false),
    DayHours(dayName: "Saturday", isOpen: false),
  ].obs;

  // 💡 API State Management
  final RxBool isLoading = false.obs;
  final RxnString apiError = RxnString(null);

  // --- C. Available Options ---
  final List<String> roleOptions = ["Owner", "Manager", "Operator"];
  final List<String> availableServicesOptions = [
    "Home Repairs & Maintenance", "Cleaning & Organization", "Renovations & Upgrades",
    "Electrical Services", "Plumbing Services", "HVAC Services",
  ];

  // --- D. Setters & Logic ---

  void setSelectedCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  void setSelectedRole(String? role) {
    selectedRole.value = role;
  }

  void setSelectedServices(List<String> services) {
    selectedServices.assignAll(services);
  }

  void setBusinessHours(List<DayHours> hours) {
    businessHours.assignAll(hours);
  }

  String _formatTimeForApi(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '$hour.$minute$period';
  }

  Map<String, dynamic> prepareDataPayload() {
    final openDays = businessHours.where((day) => day.isOpen).toList();

    return {
      "email": emailController.text.trim(),
      "password": passwordController.text,
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "businessName": businessNameRegisteredController.text.trim(),
      "businessNameDBA": businessNameDbaController.text.trim(),
      "businessWebsite": businessWebsiteController.text.trim(),
      "phone": selectedCountryCode.value + phoneNumberController.text.trim(),
      "providerRole": selectedRole.value?.toLowerCase(),
      "servicesProvided": selectedServices.toList(),
      "hourlyRate": double.tryParse(hourlyRateController.text) ?? 0.0,

      "businessAddress": {
        "street": businessAddressController.text.trim(),
      },

      "businessServiceDays": {
        "start": openDays.isNotEmpty ? openDays.first.dayName.toLowerCase().substring(0, 3) : null,
        "end": openDays.isNotEmpty ? openDays.last.dayName.toLowerCase().substring(0, 3) : null,
      },
      "businessHours": {
        "start": openDays.isNotEmpty ? _formatTimeForApi(openDays.first.startTime) : null,
        "end": openDays.isNotEmpty ? _formatTimeForApi(openDays.first.endTime) : null,
      },
    };
  }

  Future<bool> registerProvider() async {
    isLoading.value = true;
    apiError.value = null;

    if (passwordController.text != confirmPasswordController.text) {
      apiError.value = "Password and Confirm Password do not match.";
      isLoading.value = false;
      return false;
    }

    final String url = '$_baseUrl/register/provider';
    final payload = prepareDataPayload();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          print("Registration Successful: ${responseBody['message']}");
          return true;
        } else {
          apiError.value = responseBody['message'] ?? "Registration failed due to server error.";
          return false;
        }
      } else {
        apiError.value = "Server responded with status code: ${response.statusCode}";
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      apiError.value = "Network Error: Could not connect to server.";
      print("API Error: $e");
      return false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    businessNameRegisteredController.dispose();
    businessNameDbaController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    businessAddressController.dispose();
    phoneNumberController.dispose();
    businessWebsiteController.dispose();
    hourlyRateController.dispose();
    super.onClose();
  }
}