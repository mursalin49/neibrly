import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/screen/Users/Home/create_bundle_bottomsheet.dart';
import 'package:naibrly/widgets/bundle_card.dart';
import 'package:naibrly/widgets/service_request_card.dart';
import 'package:naibrly/services/mock_data_service.dart';
import '../Bundles/bundels_screen.dart';
import 'base/popularService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedLanguage = "Category"; // stores selected language
  final List<String> languages = ["Home", "Service", "Popular", "Organization"];
  
  List<Map<String, dynamic>> bundles = [];
  bool isLoadingBundles = true;
  int? expandedIndex;
  
  // Popular search dropdown
  final TextEditingController _popularSearchController = TextEditingController();
  final GlobalKey _popularSearchFieldKey = GlobalKey();
  final LayerLink _popularSearchLink = LayerLink();
  OverlayEntry? _popularOverlay;
  double _popularFieldWidth = 0;
  final List<String> _popularItems = const [
    'Home Repairs',
    'Cleaning & Organization',
    'Renovations & Upgrades',
  ];
  
  // Service request state
  bool showServiceRequests = true;
  Map<String, dynamic>? currentServiceRequest;

  @override
  void initState() {
    super.initState();
    _loadBundles();
    _loadServiceRequest();
  }

  Future<void> _loadBundles() async {
    await MockDataService.initialize();
    
    setState(() {
      bundles = MockDataService.getActiveBundles().take(3).toList();
      isLoadingBundles = false;
    });
  }

  Future<void> _loadServiceRequest() async {
    // Load a single service request
    setState(() {
      currentServiceRequest = {
        'serviceName': 'Appliance Repairs',
        'pricePerHour': 63.0,
        'clientName': 'Jane Doe',
        'clientImage': 'assets/images/jane.png',
        'clientRating': 5.0,
        'clientReviewCount': 55,
        'address': '123 Oak Street Springfield, IL 62704',
        'date': '15 Jan 2024',
        'time': '10:00 AM',
        'problemNote': 'My refrigerator is not cooling properly. The freezer works but the main compartment is warm.',
      };
    });
  }

  void _openPopularSearches() {
    if (_popularOverlay != null) return;
    final overlay = Overlay.of(context);
    if (overlay == null) return;
    final RenderBox? box = _popularSearchFieldKey.currentContext?.findRenderObject() as RenderBox?;
    _popularFieldWidth = box?.size.width ?? 0;

    _popularOverlay = OverlayEntry(
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closePopularSearches,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: _popularSearchLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 48 + 4),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: _popularFieldWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                        child: Text(
                          'Popular searches',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ..._popularItems.map((item) => InkWell(
                            onTap: () {
                              setState(() {
                                _popularSearchController.text = item;
                              });
                              _closePopularSearches();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              child: Row(
                                children: [
                                  Icon(Icons.search, size: 18, color: Colors.grey.shade700),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_popularOverlay!);
  }

  void _closePopularSearches() {
    _popularOverlay?.remove();
    _popularOverlay = null;
  }

  void _handleServiceRequestCancel() {
    setState(() {
      showServiceRequests = false;
      currentServiceRequest = null;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Service request cancelled.'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _handleServiceRequestAccept() {
    setState(() {
      showServiceRequests = false;
      currentServiceRequest = null;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Service request accepted!'),
        backgroundColor: Colors.green,
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
        // Refresh data
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.White,
        title: RichText(
          text: TextSpan(
            text: "Welcome to ",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: "Naibrly,",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " Find Services,",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.White,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
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
                    child: CompositedTransformTarget(
                      link: _popularSearchLink,
                      child: TextFormField(
                        key: _popularSearchFieldKey,
                        controller: _popularSearchController,
                        readOnly: true,
                        onTap: _openPopularSearches,
                        decoration: const InputDecoration(
                          hintText: "Home Repairs",
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        style: TextStyle(color: AppColors.textcolor),
                      ),
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

                        hintText: "59856",
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
            const SizedBox(height: 10),
            
            // Service Requests Section (only show if there are requests)
            if (showServiceRequests && currentServiceRequest != null) ...[
              Row(
                children: [
                  AppText(
                    "Service Requests",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 12),
                  SvgPicture.asset("assets/icons/Icon (4).svg"),
                  const Spacer(),
                  AppText(
                    "1 Pending",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Single Service Request Card
              ServiceRequestCard(
                serviceName: currentServiceRequest!['serviceName'],
                pricePerHour: currentServiceRequest!['pricePerHour'],
                clientName: currentServiceRequest!['clientName'],
                clientImage: currentServiceRequest!['clientImage'],
                clientRating: currentServiceRequest!['clientRating'],
                clientReviewCount: currentServiceRequest!['clientReviewCount'],
                address: currentServiceRequest!['address'],
                date: currentServiceRequest!['date'],
                time: currentServiceRequest!['time'],
                problemNote: currentServiceRequest!['problemNote'],
                onAccept: _handleServiceRequestAccept,
                onCancel: _handleServiceRequestCancel,
              ),
              
              const SizedBox(height: 20),
            ],
            
            // Bundles Section
            Row(
              children: [
                AppText(
                  "Naibrly Bundles",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.black,
                ),
                const SizedBox(width: 12),
                SvgPicture.asset("assets/icons/Icon (4).svg"),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BundelsScreen()),
                    );
                  },
                  child: AppText(
                    "View All",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Bundle Cards
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
                      publishedText: 'Published 1hr ago',
                      originalPrice: '\$${bundle['originalPrice']}',
                      discountedPrice: '\$${bundle['discountedPrice']}',
                      savings: '-\$${bundle['originalPrice'] - bundle['discountedPrice']}',
                      providers: List<Map<String, dynamic>>.from(bundle['providers'] ?? []),
                      benefits: List<String>.from(bundle['benefits'] ?? []),
                      participants: bundle['participants'],
                      maxParticipants: bundle['maxParticipants'],
                      serviceDate: bundle['expiryDate'],
                      discountPercentage: bundle['discountPercentage'],
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

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 42,
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BundelsScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFF0E7A60),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Naibrly Bundles",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E7A60),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Popular Services Section
            Row(
              children: [
                AppText(
                  "Popular Services",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.black,
                ),
                const SizedBox(width: 12),
                SvgPicture.asset("assets/icons/Icon (4).svg"),
                const Spacer(),
                buildLanguageSelector(languages, selectedLanguage),
              ],
            ),
            //SalaryRangeSlider(),
            const SizedBox(height: 5),
            Popularservice(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PopupMenuButton<String> buildLanguageSelector(
      List<String> languages,
      String? selectedValue,
      ) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 45),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        setState(() {
          selectedLanguage = value;
        });
        debugPrint("Selected Language: $value");
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          enabled: false,
          child: AppText(
            "Select Category",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xff71717A),
          ),
        ),
        ...languages.map(
              (lang) => PopupMenuItem<String>(
            value: lang,
            child: Row(
              children: [
                if (selectedLanguage == lang)
                  const Icon(Icons.check, color: Colors.green, size: 16),
                if (selectedLanguage == lang) const SizedBox(width: 6),
                AppText(
                  lang,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF000000).withOpacity(0.10),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            AppText(
              selectedLanguage ?? "Category",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            const SizedBox(width: 8),
            SvgPicture.asset("assets/icons/elements (1).svg"),
          ],
        ),
      ),
    );
  }
}

class SalaryRangeSlider extends StatelessWidget {
  SalaryRangeSlider({Key? key}) : super(key: key);

  final List<double> chartData = [0.1, 0.1, 0.3, 0.1, 0.8, 0.0,0.0,0.0,0.4,0.0,0.0,0.1];

  @override
  Widget build(BuildContext context) {
    final double maxValue = chartData.isNotEmpty ? chartData.reduce((a, b) => a > b ? a : b) : 1.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Bar chart
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.34,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: chartData.map((value) {
              final double normalizedHeight = (value / maxValue) * 100; // auto scale based on max value
              return Container(
                width: 10,
                height: normalizedHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFFB4F4D3),
                ),
              );
            }).toList(),
          ),
        ),

        Stack(
          children: [
            // Line
            Positioned(
              top: 0,
              left: 12,
              right: 12,
              child: Container(
                height: 2,
                color: AppColors.primary,
              ),
            ),
            // Circles and labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left circle
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$10',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                // Right circle
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$150+',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'avg. rate is \$56.78/hr',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

