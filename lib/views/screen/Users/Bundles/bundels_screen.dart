import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';
import 'package:naibrly/widgets/bundle_card.dart';
import 'package:naibrly/services/mock_data_service.dart';
import 'package:naibrly/views/screen/Users/Home/create_bundle_bottomsheet.dart';

class BundelsScreen extends StatefulWidget {
  const BundelsScreen({super.key});

  @override
  State<BundelsScreen> createState() => _BundelsScreenState();
}

class _BundelsScreenState extends State<BundelsScreen> {
  List<Map<String, dynamic>> bundles = [];
  List<Map<String, dynamic>> categories = [];
  String selectedCategory = 'All';
  int? expandedIndex;
  bool isLoading = true;
  
  // Filter dropdowns
  String selectedFilter1 = 'Interior';
  String selectedFilter2 = 'Home...';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await MockDataService.initialize();
    
    setState(() {
      bundles = MockDataService.getActiveBundles();
      categories = MockDataService.getCategories();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        elevation: 0,
        title: const AppText(
          "Naibrly Bundles",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Handle search action
            },
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          //_buildCategoryFilter(),

          // Bundles List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 0.8,
                        color: AppColors.textcolor.withOpacity(0.25),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Home Repairs",
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(color: AppColors.textcolor),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 30, // control height of divider line
                          color: AppColors.textcolor.withOpacity(0.4),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        SvgPicture.asset("assets/icons/location.svg"),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(

                                hintText: "Zip code",
                                border: InputBorder.none,
                                isCollapsed: true,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black.withOpacity(0.50),
                                )
                            ),
                            style: TextStyle(color: AppColors.textcolor),
                          ),
                        ),
                        Container(
                          width: 45,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset("assets/icons/search-normal.svg"),
                          ),
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Filter Section
                  _buildFilterSection(),

                  const SizedBox(height: 20),

                  // Bundle Cards
                     ...bundles.asMap().entries.map((entry) {
                       final index = entry.key;
                       final bundle = entry.value;

                       return Column(
                         children: [
                           BundleCard(
                             serviceTitle: bundle['title'] ?? 'Unknown Bundle',
                             originalPrice: '\$${bundle['originalPrice']}',
                             discountedPrice: '\$${bundle['discountedPrice']}',
                             savings: '-\$${bundle['originalPrice'] - bundle['discountedPrice']}',
                             providers: List<Map<String, dynamic>>.from(bundle['providers'] ?? []),
                             benefits: List<String>.from(bundle['benefits'] ?? []),
                             participants: bundle['participants'],
                             maxParticipants: bundle['maxParticipants'],
                             serviceDate: bundle['expiryDate'],
                             discountPercentage: bundle['discountPercentage'],
                             publishedText: 'Published 1hr ago',
                             isExpanded: expandedIndex == index,
                             onToggleExpansion: () {
                               setState(() {
                                 expandedIndex = expandedIndex == index ? null : index;
                               });
                             },
                             onJoinBundle: () {
                               _handleJoinBundle(bundle['id']);
                             },
                           ),
                           if (index < bundles.length - 1) const SizedBox(height: 12),
                         ],
                       );
                     }),

                  const SizedBox(height: 20),
                  
                  // Create Bundle Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const CreateBundleBottomSheet(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E7A60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Create Bundle",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Row(
      children: [
        // Naibrly Bundles text
        const AppText(
          "Naibrly Bundles",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        
        const Spacer(),
        
        // First dropdown - Interior
        Container(
          width: 100, // Fixed width to prevent overflow
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedFilter1,
              isDense: true,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black),
              items: const [
                DropdownMenuItem(value: 'Interior', child: Text('Interior', style: TextStyle(fontSize: 12))),
                DropdownMenuItem(value: 'Exterior', child: Text('Exterior', style: TextStyle(fontSize: 12))),
                DropdownMenuItem(value: 'Maintenance', child: Text('Maintenance', style: TextStyle(fontSize: 12))),
              ],
              onChanged: (value) {
                setState(() {
                  selectedFilter1 = value!;
                });
              },
            ),
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Second dropdown - Home...
        Container(
          width: 100, // Fixed width to prevent overflow
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedFilter2,
              isDense: true,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black),
              items: const [
                DropdownMenuItem(value: 'Home...', child: Text('Home...', style: TextStyle(fontSize: 12))),
                DropdownMenuItem(value: 'Office', child: Text('Office', style: TextStyle(fontSize: 12))),
                DropdownMenuItem(value: 'Commercial', child: Text('Commercial', style: TextStyle(fontSize: 12))),
              ],
              onChanged: (value) {
                setState(() {
                  selectedFilter2 = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // All Categories Button
          _buildCategoryChip('All', selectedCategory == 'All'),
          const SizedBox(width: 8),
          
          // Category Chips
          ...categories.map((category) {
            final categoryName = category['name'] ?? 'Unknown';
            final isSelected = selectedCategory == categoryName;
            
            return Row(
              children: [
                _buildCategoryChip(categoryName, isSelected),
                const SizedBox(width: 8),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String name, bool isSelected) {
    return IosTapEffect(
      onTap: () {
        setState(() {
          selectedCategory = name;
        });
        _filterBundlesByCategory();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: AppText(
          name,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : Colors.grey.shade600,
        ),
      ),
    );
  }

  void _filterBundlesByCategory() {
    if (selectedCategory == 'All') {
      setState(() {
        bundles = MockDataService.getActiveBundles();
      });
    } else {
      setState(() {
        bundles = MockDataService.getBundlesByCategory(selectedCategory);
      });
    }
  }

  Future<void> _handleJoinBundle(String bundleId) async {
    try {
      final success = await MockDataService.joinBundle(bundleId);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully joined bundle!'),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh data
        _loadData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to join bundle. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
