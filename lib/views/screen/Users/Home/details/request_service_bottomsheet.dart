import 'package:flutter/material.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/screen/Users/Home/details/request_success_bottomsheet.dart';
import 'package:naibrly/views/screen/Users/Home/details/request_failed_bottomsheet.dart';
import 'dart:math';

class RequestServiceBottomSheet extends StatefulWidget {
  final String serviceName;
  final String providerName;

  const RequestServiceBottomSheet({
    Key? key,
    required this.serviceName,
    required this.providerName,
  }) : super(key: key);

  @override
  State<RequestServiceBottomSheet> createState() => _RequestServiceBottomSheetState();
}

class _RequestServiceBottomSheetState extends State<RequestServiceBottomSheet> {
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _problemController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeader(),
          
          const SizedBox(height: 24),
          
          // Form Fields
          _buildProblemField(),
          const SizedBox(height: 16),
          _buildNoteField(),
          const SizedBox(height: 16),
          _buildDateField(),
          const SizedBox(height: 16),
          _buildTimeField(),
          
          const SizedBox(height: 32),
          
          // Request Button
          _buildRequestButton(),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: AppText(
            widget.serviceName,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: AppText(
            "Average response time: 10 minutes (by ${widget.providerName})",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
        )
      ],
    );
  }

  Widget _buildProblemField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "Problem*",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _problemController,
          decoration: InputDecoration(
            hintText: "Type here",
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          ),
        ),
      ],
    );
  }

  Widget _buildNoteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "Note*",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _noteController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Type here",
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "Date*",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                        : "Select date",
                    style: TextStyle(
                      color: _selectedDate != null ? Colors.black : Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "Approximately time*",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _selectTime,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime != null
                        ? "${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}"
                        : "00:00",
                    style: TextStyle(
                      color: _selectedTime != null ? Colors.black : Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleRequestSent,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF28C28), // Orange color
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const AppText(
          "Request Sent",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _handleRequestSent() {
    // Validate required fields
    if (_problemController.text.trim().isEmpty) {
      _showErrorSnackBar("Please enter the problem");
      return;
    }
    if (_noteController.text.trim().isEmpty) {
      _showErrorSnackBar("Please enter a note");
      return;
    }
    if (_selectedDate == null) {
      _showErrorSnackBar("Please select a date");
      return;
    }
    if (_selectedTime == null) {
      _showErrorSnackBar("Please select a time");
      return;
    }

    // Close the current bottom sheet
    Navigator.pop(context);
    
    // Randomly determine success or failure (70% success rate)
    final random = Random();
    final isSuccess = random.nextDouble() < 0.7;
    
    // Show success or failure bottom sheet
    if (isSuccess) {
      _showSuccessBottomSheet();
    } else {
      _showFailedBottomSheet();
    }
  }

  void _showSuccessBottomSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RequestSuccessBottomSheet(
        providerName: widget.providerName,
      ),
    );
  }

  void _showFailedBottomSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RequestFailedBottomSheet(
        providerName: widget.providerName,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
