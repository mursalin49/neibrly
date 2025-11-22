import 'package:flutter/material.dart';
import 'package:naibrly/services/mock_data_service.dart';
import 'package:naibrly/views/base/AppText/appText.dart';

class ExampleUsageScreen extends StatefulWidget {
  const ExampleUsageScreen({Key? key}) : super(key: key);

  @override
  State<ExampleUsageScreen> createState() => _ExampleUsageScreenState();
}

class _ExampleUsageScreenState extends State<ExampleUsageScreen> {
  List<Map<String, dynamic>> services = [];
  List<Map<String, dynamic>> bundles = [];
  List<Map<String, dynamic>> providers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Initialize the mock data service
    await MockDataService.initialize();
    
    setState(() {
      // Get different types of data
      services = MockDataService.getPopularServices();
      bundles = MockDataService.getActiveBundles();
      providers = MockDataService.getAvailableProviders();
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
      appBar: AppBar(
        title: const Text('Mock Data Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Services Section
            const AppText(
              'Popular Services',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            ...services.map((service) => _buildServiceCard(service)),
            
            const SizedBox(height: 32),
            
            // Bundles Section
            const AppText(
              'Active Bundles',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            ...bundles.map((bundle) => _buildBundleCard(bundle)),
            
            const SizedBox(height: 32),
            
            // Providers Section
            const AppText(
              'Available Providers',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            ...providers.map((provider) => _buildProviderCard(provider)),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.build),
        ),
        title: AppText(
          service['title'] ?? 'Unknown Service',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              service['description'] ?? '',
              fontSize: 12,
              color: Colors.grey.shade600,
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                AppText(
                  '${service['rating']} (${service['reviewCount']} reviews)',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                const Spacer(),
                AppText(
                  '\$${service['averagePrice']}',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0E7A60),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          // Handle service tap
          _showServiceDetails(service);
        },
      ),
    );
  }

  Widget _buildBundleCard(Map<String, dynamic> bundle) {
    final provider = bundle['provider'] as Map<String, dynamic>;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    bundle['title'] ?? 'Unknown Bundle',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E7A60),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AppText(
                    '${bundle['discountPercentage']}% OFF',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppText(
              bundle['description'] ?? '',
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                AppText(
                  '\$${bundle['originalPrice']}',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                  decoration: TextDecoration.lineThrough,
                ),
                const SizedBox(width: 8),
                AppText(
                  '\$${bundle['discountedPrice']}',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0E7A60),
                ),
                const Spacer(),
                AppText(
                  '${bundle['participants']}/${bundle['maxParticipants']} joined',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.person, size: 16),
                ),
                const SizedBox(width: 8),
                AppText(
                  provider['name'] ?? 'Unknown Provider',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _joinBundle(bundle['id']);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E7A60),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const AppText(
                    'Join Bundle',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> provider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.person),
        ),
        title: Row(
          children: [
            AppText(
              provider['name'] ?? 'Unknown Provider',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: provider['isAvailable'] == true 
                    ? Colors.green 
                    : Colors.red,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                AppText(
                  '${provider['rating']} (${provider['reviewCount']} reviews)',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
            const SizedBox(height: 4),
            AppText(
              provider['location'] ?? '',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            AppText(
              provider['price'] ?? '',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0E7A60),
            ),
          ],
        ),
        onTap: () {
          _showProviderDetails(provider);
        },
      ),
    );
  }

  void _showServiceDetails(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppText(service['title'] ?? 'Service Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText('Price: \$${service['averagePrice']}'),
            AppText('Category: ${service['category']}'),
            AppText('Rating: ${service['rating']}'),
            AppText('Reviews: ${service['reviewCount']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showProviderDetails(Map<String, dynamic> provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppText(provider['name'] ?? 'Provider Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText('Rating: ${provider['rating']}'),
            AppText('Reviews: ${provider['reviewCount']}'),
            AppText('Status: ${provider['status']}'),
            AppText('Experience: ${provider['yearsExperience']} years'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _joinBundle(String bundleId) async {
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
