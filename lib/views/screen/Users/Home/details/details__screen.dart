import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';
import 'package:naibrly/views/screen/Users/Home/details/provider_details_screen.dart';
import 'package:naibrly/widgets/bundle_card.dart';
import 'package:naibrly/services/mock_data_service.dart';
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int? expandedIndex;
  List<Map<String, dynamic>> bundles = [];
  bool isLoadingBundles = true;

  @override
  void initState() {
    super.initState();
    _loadBundles();
  }

  Future<void> _loadBundles() async {
    await MockDataService.initialize();
    setState(() {
      bundles = MockDataService.getActiveBundles();
      isLoadingBundles = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.White,
        title: const Text("Appliance Repairs"),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.White,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Card with Image, Title and Price
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.White,
                borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      offset: const Offset(0, 1),
                      blurRadius: 15,
                    ),
                  ],
                  border: Border.all(
                    width: 0.8,
                    color: Colors.black.withOpacity(0.10),
                  ),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // Image
                    ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.asset(
                      "assets/images/e0a5051b9af8512d821599ee993492a9954bb256.png",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  // Title and Price
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                          "Appliance Repairs",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: const TextSpan(
                          text: "Avg. price: ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                                text: "\$110 - \$140",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0E7A60),
                                  fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Service Description Section
            const AppText(
              "Appliance Repairs Service",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 12),
            AppText(
              "Our Appliance Repairs service covers the repair of your everyday appliances, such as refrigerators, washing machines, microwaves, air conditioners, and more. Our experienced technicians will efficiently and effectively solve any issues with your appliances.",
              color: AppColors.textcolor.withOpacity(0.8),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            
            const SizedBox(height: 30),
            
            // Naibrly Bundles Section
            Row(
              children: [
                const AppText(
                  "Naibrly Bundles",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                const Spacer(),
                IosTapEffect(
                  onTap: () {
                    // Handle see all action
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.primary, width: 1),
                    ),
                    child: const AppText(
                      "See all",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0E7A60),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Bundle Items - Using reusable BundleCard widget
            if (isLoadingBundles)
              const Center(child: CircularProgressIndicator())
            else
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
            
            const SizedBox(height: 30),
            
            // Appliance Repair Providers Section
            const AppText(
              "Appliance Repair Providers",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            
            // Average Cost Section
            _buildAverageCostSection(),
            
            const SizedBox(height: 20),
            
            // Provider Cards
            _buildProviderCard("Jacob Brothers", "5.0 (1,513 reviews)", "Online Now", "12 similar jobs done near you", "\$63/hr estimated budget", "Jacob says, \"the repair person come on time, diagnosed and fixed the issue with my leaking wa...\""),
            const SizedBox(height: 12),
            _buildProviderCard("Jacob Brothers", "5.0 (1,513 reviews)", "Online Now", "12 similar jobs done near you", "\$63/hr estimated budget", "Jacob says, \"the repair person come on time, diagnosed and fixed the issue with my leaking wa...\""),
          ],
        ),
      ),
    );
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
        // Refresh bundles
        _loadBundles();
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
  
  Widget _buildAverageCostSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 1),
            blurRadius: 15,
          ),
        ],
        border: Border.all(
          width: 0.8,
          color: Colors.black.withOpacity(0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppText(
                "\$68/consult",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 4),
          const AppText(
            "Avg. cost in your area",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          
          // Slider Section
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB4F4D3), Color(0xFF0E7A60)],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              Positioned(
                left: 200, // Position the thumb
                top: -8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF0E7A60), width: 2),
                  ),
                ),
              ),
              Positioned(
                left: 180,
                top: -25,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E7A60),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const AppText(
                    "\$68/consult avg.",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildProviderCard(String name, String rating, String status, String location, String price, String review) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderDetailsScreen(
              providerName: name,
              rating: rating,
              status: status,
              location: location,
              price: price,
              review: review,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 1),
              blurRadius: 15,
            ),
          ],
          border: Border.all(
            width: 0.8,
            color: Colors.black.withOpacity(0.10),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/home.png'),
            SizedBox(width: 10),
            // Provider Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    name,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 4),
                  
                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 4),
                      AppText(
                        rating,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Status
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0E7A60),
                        ),
                      ),
                      const SizedBox(width: 6),
                      AppText(
                        status,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF0E7A60),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Location
                  Row(
                    children: [
                      Image.asset('assets/images/location.png', width: 12, height: 12),
                      const SizedBox(width: 4),
                      AppText(
                        location,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Price
                  AppText(
                    price,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  
                  // Review
                  AppText(
                    review,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




