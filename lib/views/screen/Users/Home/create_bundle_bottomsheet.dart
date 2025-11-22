import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';
import 'package:naibrly/views/screen/Users/Home/bundle_published_bottomsheet.dart';
import 'package:naibrly/provider/widgets/custom_single_select_dropdown.dart';
import 'package:naibrly/views/base/pickers/custom_date_picker.dart';
import 'package:naibrly/views/base/pickers/custom_time_picker.dart';

class CreateBundleBottomSheet extends StatefulWidget {
  const CreateBundleBottomSheet({super.key});

  @override
  State<CreateBundleBottomSheet> createState() => _CreateBundleBottomSheetState();
}

class _CreateBundleBottomSheetState extends State<CreateBundleBottomSheet> {
  String? selectedCategory;
  // Dropdown states
  String? selectedPrimary;
  String? selectedSecondary;
  String? selectedTertiary;
  DateTime? serviceDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  
  final List<String> categories = [
    'Interior',
    'Door & Window',
    'Plumbing',
    'Electrical',
    'HVAC',
    'Cleaning',
    'Maintenance'
  ];

  // Primary dropdown options
  final List<String> primaryOptions = [
    'Interior',
    'Exterior',
    'More Services',
    'House Painter',
  ];

  // Secondary options mapped by primary selection
  final Map<String, List<String>> secondaryByPrimary = {
    'Interior': [
      'Home Repairs & Maintenance',
      'Cleaning & Organization',
      'Renovations & Upgrades',
    ],
    'Exterior': [
      'Exterior Home Care',
      'Landscaping & Outdoor Services',
    ],
    'More Services': [
      'Moving',
      'Installation & Assembly',
    ],
    'House Painter': [
      'Interior Painting',
      'Exterior Painting',
    ],
  };

  // Tertiary options mapped by secondary selection (sample specific services)
  final Map<String, List<String>> tertiaryBySecondary = {
    'Home Repairs & Maintenance': ['Electrical', 'Plumbing', 'HVAC'],
    'Cleaning & Organization': ['Deep Cleaning', 'Standard Cleaning'],
    'Renovations & Upgrades': ['Kitchen Remodel', 'Bathroom Remodel'],
    'Exterior Home Care': ['Window Washing', 'Roof Cleaning'],
    'Landscaping & Outdoor Services': ['Lawn Mowing', 'Hedge Trimming'],
    'Moving': ['Local Moving', 'Long Distance'],
    'Installation & Assembly': ['Furniture Assembly', 'Appliance Installation'],
    'Interior Painting': ['Walls', 'Ceilings'],
    'Exterior Painting': ['Walls', 'Fences'],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
            // Header
            Center(
              child: Column(
                children: [
                  const AppText(
                    "Create Bundle",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    "Bundle Target: 3 Users (within 10 miles)",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textcolor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Primary/Secondary/Tertiary Dropdowns
            const AppText(
              "Select Category*",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            const SizedBox(height: 12),

            // Primary + Secondary (side by side)
            Row(
              children: [
                Expanded(
                  child: CustomSingleSelectDropdown(
                    hint: "Select Primary",
                    items: primaryOptions,
                    selectedItem: selectedPrimary,
                    onChanged: (value) {
                      setState(() {
                        selectedPrimary = value;
                        // reset dependent selections
                        selectedSecondary = null;
                        selectedTertiary = null;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Opacity(
                    opacity: selectedPrimary == null ? 0.5 : 1,
                    child: IgnorePointer(
                      ignoring: selectedPrimary == null,
                      child: CustomSingleSelectDropdown(
                        hint: "Select Service",
                        items: secondaryByPrimary[selectedPrimary] ?? [],
                        selectedItem: selectedSecondary,
                        onChanged: (value) {
                          setState(() {
                            selectedSecondary = value;
                            selectedTertiary = null;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Tertiary dropdown depends on secondary
            Opacity(
              opacity: selectedSecondary == null ? 0.5 : 1,
              child: IgnorePointer(
                ignoring: selectedSecondary == null,
                child: CustomSingleSelectDropdown(
                  hint: "Select Specific Service",
                  items: tertiaryBySecondary[selectedSecondary] ?? [],
                  selectedItem: selectedTertiary,
                  onChanged: (value) {
                    setState(() {
                      selectedTertiary = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Service Date Selection
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  "Service Date*",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                const SizedBox(height: 8),
                _buildDateField("Select date", serviceDate, (date) {
                  setState(() {
                    serviceDate = date;
                  });
                }),
              ],
            ),
            const SizedBox(height: 24),
            
            // Time Selection Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "From*",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 8),
                      _buildTimeField("00:00", fromTime, (time) {
                        setState(() {
                          fromTime = time;
                        });
                      }),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "To Time*",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 8),
                      _buildTimeField("00:00", toTime, (time) {
                        setState(() {
                          toTime = time;
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Close the create bundle bottom sheet
                  Navigator.pop(context);
                  
                  // Show the success bottom sheet
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const BundlePublishedBottomSheet(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043), // Orange color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Publish",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
              SizedBox(height: 10),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildCategoryChip(String text) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light greenish-grey
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String hint, DateTime? selectedDate, Function(DateTime?) onDateSelected) {
    return IosTapEffect(
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => CustomDatePicker(
            selectedDate: selectedDate,
            onDateSelected: (d) => onDateSelected(d),
            onClose: () => Navigator.of(context).pop(),
          ),
        );
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate != null 
                  ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                  : hint,
                style: TextStyle(
                  fontSize: 14,
                  color: selectedDate != null ? Colors.black : Colors.grey,
                ),
              ),
            ),
            const Icon(
              Icons.calendar_today,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField(String hint, TimeOfDay? selectedTime, Function(TimeOfDay?) onTimeSelected) {
    return IosTapEffect(
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => CustomTimePicker(
            selectedTime: selectedTime,
            onTimeSelected: (t) => onTimeSelected(t),
            onClose: () => Navigator.of(context).pop(),
          ),
        );
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedTime != null 
                  ? selectedTime!.format(context)
                  : hint,
                style: TextStyle(
                  fontSize: 14,
                  color: selectedTime != null ? Colors.black : Colors.grey,
                ),
              ),
            ),
            const Icon(
              Icons.access_time,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
