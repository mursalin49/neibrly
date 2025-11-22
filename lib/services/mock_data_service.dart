class MockDataService {
  static Map<String, dynamic>? _data;

  // Initialize the data with hardcoded mock data
  static Future<void> initialize() async {
    if (_data == null) {
      // Simulate loading delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      _data = {
        'services': [
          {
            'id': '1',
            'title': 'Appliance Repairs',
            'description': 'Professional appliance repair services for all major brands. Our certified technicians can fix refrigerators, washing machines, dryers, dishwashers, ovens, and more.',
            'averagePrice': 85,
            'image': 'assets/images/appliance_repair.png',
            'category': 'Home Services',
            'rating': 4.8,
            'reviewCount': 1247,
            'isPopular': true
          },
          {
            'id': '2',
            'title': 'Furnace Repairs',
            'description': 'Expert furnace repair and maintenance services. We handle all types of furnaces including gas, electric, and oil furnaces.',
            'averagePrice': 120,
            'image': 'assets/images/furnace_repair.png',
            'category': 'HVAC',
            'rating': 4.9,
            'reviewCount': 892,
            'isPopular': true
          },
          {
            'id': '3',
            'title': 'House Cleaning Services',
            'description': 'Professional house cleaning services for residential properties. We offer regular cleaning, deep cleaning, move-in/move-out cleaning.',
            'averagePrice': 65,
            'image': 'assets/images/cleaning_services.png',
            'category': 'Cleaning',
            'rating': 4.7,
            'reviewCount': 2156,
            'isPopular': true
          }
        ],
        'bundles': [
          {
            'id': '1',
            'title': 'Home Maintenance Bundle',
            'description': 'Complete home maintenance package including appliance repair, plumbing, and electrical services',
            'originalPrice': 300,
            'discountedPrice': 240,
            'discountPercentage': 20,
            'participants': 8,
            'maxParticipants': 10,
            'expiryDate': '2024-02-15',
            'category': 'Home Services',
            'image': 'assets/images/home_bundle.png',
            'providers': [
              {
                'name': 'Jacob Brothers',
                'rating': 5.0,
                'reviewCount': 1513,
                'avatar': 'assets/images/jane.png',
                'location': 'Street Springfield, IL 62704'
              },
              {
                'name': 'Mike\'s Handyman Services',
                'rating': 4.7,
                'reviewCount': 892,
                'avatar': 'assets/images/jane.png',
                'location': 'Street Springfield, IL 62704'
              },
              {
                'name': 'ProFix Solutions',
                'rating': 4.9,
                'reviewCount': 634,
                'avatar': 'assets/images/jane.png',
                'location': 'Street Springfield, IL 62704'
              }
            ],
            'benefits': [
              '20% discount on all services',
              'Priority scheduling',
              'Extended warranty coverage',
              'Free consultation'
            ],
            'isExpired': false,
            'isJoined': false
          },
          {
            'id': '2',
            'title': 'Spring Cleaning Special',
            'description': 'Deep cleaning package for spring season including interior and exterior cleaning',
            'originalPrice': 200,
            'discountedPrice': 150,
            'discountPercentage': 25,
            'participants': 12,
            'maxParticipants': 15,
            'expiryDate': '2024-03-20',
            'category': 'Cleaning',
            'image': 'assets/images/cleaning_bundle.png',
            'providers': [
              {
                'name': 'Johan Services',
                'rating': 4.8,
                'reviewCount': 892,
                'avatar': 'assets/images/jane.png',
                'location': 'Street Springfield, IL 62704'
              },
              {
                'name': 'Sparkle Clean Co.',
                'rating': 4.6,
                'reviewCount': 445,
                'avatar': 'assets/images/jane.png',
                'location': 'Street Springfield, IL 62704'
              }
            ],
            'benefits': [
              '25% discount on cleaning services',
              'Eco-friendly products',
              'Satisfaction guarantee',
              'Free estimate'
            ],
            'isExpired': false,
            'isJoined': false
          },
          {
            'id': '3',
            'title': 'HVAC Maintenance Package',
            'description': 'Complete HVAC maintenance including furnace repair, AC service, and duct cleaning',
            'originalPrice': 400,
            'discountedPrice': 320,
            'discountPercentage': 20,
            'participants': 5,
            'maxParticipants': 8,
            'expiryDate': '2024-01-30',
            'category': 'HVAC',
            'image': 'assets/images/hvac_bundle.png',
            'providers': [
              {
                'name': 'Climate Control Experts',
                'rating': 4.9,
                'reviewCount': 634,
                'avatar': 'assets/images/jane.png',
                'location': 'Street Springfield, IL 62704'
              },
              {
                'name': 'AirFlow Solutions',
                'rating': 4.5,
                'reviewCount': 312,
                'avatar': 'assets/images/jane.png',
                'location': 'Street Springfield, IL 62704'
              },
              {
                'name': 'Comfort Zone HVAC',
                'rating': 4.7,
                'reviewCount': 523,
                'avatar': 'assets/images/jane.png',
                'location': 'Street Springfield, IL 62704'
              }
            ],
            'benefits': [
              '20% discount on HVAC services',
              'Annual maintenance plan',
              'Emergency service priority',
              'Energy efficiency consultation'
            ],
            'isExpired': false,
            'isJoined': true
          }
        ],
        'providers': [
          {
            'id': '1',
            'name': 'Jacob Brothers',
            'rating': 5.0,
            'reviewCount': 1513,
            'status': 'Online Now',
            'location': '12 similar jobs done near you',
            'price': '\$63/hr estimated budget',
            'review': 'Jacob says, "the repair person come on time, diagnosed and fixed the issue with my leaking wa..."',
            'avatar': 'assets/images/home.png',
            'services': ['Appliance Repairs', 'Furnace Repairs', 'House Cleaning Services'],
            'responseTime': '10 minutes',
            'isAvailable': true,
            'specialties': ['Appliance Repair', 'HVAC', 'General Maintenance'],
            'yearsExperience': 8,
            'certifications': ['Certified Appliance Technician', 'HVAC License'],
            'languages': ['English', 'Spanish'],
            'workingHours': 'Mon-Fri: 8AM-6PM, Sat: 9AM-4PM'
          },
          {
            'id': '2',
            'name': 'Mike\'s Handyman Services',
            'rating': 4.7,
            'reviewCount': 892,
            'status': 'Online Now',
            'location': '8 similar jobs done near you',
            'price': '\$55/hr estimated budget',
            'review': 'Mike provides excellent service and always explains what needs to be done before starting work.',
            'avatar': 'assets/images/mike_avatar.png',
            'services': ['Plumbing Services', 'Electrical Services', 'General Repairs'],
            'responseTime': '15 minutes',
            'isAvailable': true,
            'specialties': ['Plumbing', 'Electrical', 'Carpentry'],
            'yearsExperience': 12,
            'certifications': ['Licensed Plumber', 'Certified Electrician'],
            'languages': ['English'],
            'workingHours': 'Mon-Sun: 7AM-8PM'
          }
        ],
        'clientFeedback': [
          {
            'id': '1',
            'clientName': 'Jessica R',
            'clientImage': 'assets/images/jessica.png',
            'rating': 4.0,
            'comment': 'Thank you for your work! The service met my expectations and I\'m very happy. The technician was professional and completed the job efficiently.',
            'date': '2024-01-15',
            'serviceType': 'Appliance Repair',
            'providerId': '1',
            'isExpanded': false
          },
          {
            'id': '2',
            'clientName': 'Maria Gosh',
            'clientImage': 'assets/images/maria.png',
            'rating': 2.0,
            'comment': 'Service was okay but could be better. The technician arrived late and the work quality was average.',
            'date': '2023-12-18',
            'serviceType': 'Furnace Repair',
            'providerId': '1',
            'isExpanded': false
          },
          {
            'id': '3',
            'clientName': 'Ethan Lert',
            'clientImage': 'assets/images/ethan.png',
            'rating': 3.0,
            'comment': 'Good work overall, minor issues with timing. The technician was friendly and the final result was satisfactory.',
            'date': '2023-11-25',
            'serviceType': 'House Cleaning',
            'providerId': '2',
            'isExpanded': false
          }
        ],
        'categories': [
          {
            'id': '1',
            'name': 'Home Services',
            'icon': 'assets/icons/home.svg',
            'color': '#0E7A60',
            'serviceCount': 15
          },
          {
            'id': '2',
            'name': 'Cleaning',
            'icon': 'assets/icons/cleaning.svg',
            'color': '#4CAF50',
            'serviceCount': 8
          },
          {
            'id': '3',
            'name': 'HVAC',
            'icon': 'assets/icons/hvac.svg',
            'color': '#FF9800',
            'serviceCount': 6
          },
          {
            'id': '4',
            'name': 'Outdoor',
            'icon': 'assets/icons/outdoor.svg',
            'color': '#8BC34A',
            'serviceCount': 12
          }
        ],
        'userProfile': {
          'id': 'user_123',
          'name': 'John Doe',
          'email': 'john.doe@email.com',
          'phone': '+1 (555) 123-4567',
          'avatar': 'assets/images/user_avatar.png',
          'address': {
            'street': '123 Main Street',
            'city': 'New York',
            'state': 'NY',
            'zipCode': '10001',
            'country': 'USA'
          },
          'preferences': {
            'notifications': true,
            'emailUpdates': true,
            'smsUpdates': false,
            'language': 'en',
            'currency': 'USD'
          },
          'joinedBundles': ['3'],
          'favoriteProviders': ['1', '2'],
          'serviceHistory': []
        },
        'appSettings': {
          'version': '1.0.0',
          'minSupportedVersion': '1.0.0',
          'apiBaseUrl': 'https://api.naibrly.com',
          'supportEmail': 'support@naibrly.com',
          'supportPhone': '+1 (555) 123-4567',
          'termsOfService': 'https://naibrly.com/terms',
          'privacyPolicy': 'https://naibrly.com/privacy',
          'features': {
            'bundlesEnabled': true,
            'chatEnabled': true,
            'videoCallEnabled': false,
            'paymentEnabled': true,
            'ratingEnabled': true
          },
          'defaultSettings': {
            'currency': 'USD',
            'language': 'en',
            'theme': 'light',
            'notifications': true
          }
        },
        'notifications': [],
        'locations': []
      };
    }
  }

  // Get all services
  static List<Map<String, dynamic>> getServices() {
    return List<Map<String, dynamic>>.from(_data?['services'] ?? []);
  }

  // Get popular services only
  static List<Map<String, dynamic>> getPopularServices() {
    final services = getServices();
    return services.where((service) => service['isPopular'] == true).toList();
  }

  // Get service by ID
  static Map<String, dynamic>? getServiceById(String id) {
    final services = getServices();
    try {
      return services.firstWhere((service) => service['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // Get services by category
  static List<Map<String, dynamic>> getServicesByCategory(String category) {
    final services = getServices();
    return services.where((service) => service['category'] == category).toList();
  }

  // Get all bundles
  static List<Map<String, dynamic>> getBundles() {
    return List<Map<String, dynamic>>.from(_data?['bundles'] ?? []);
  }

  // Get active bundles (not expired)
  static List<Map<String, dynamic>> getActiveBundles() {
    final bundles = getBundles();
    return bundles.where((bundle) => bundle['isExpired'] == false).toList();
  }

  // Get bundle by ID
  static Map<String, dynamic>? getBundleById(String id) {
    final bundles = getBundles();
    try {
      return bundles.firstWhere((bundle) => bundle['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // Get bundles by category
  static List<Map<String, dynamic>> getBundlesByCategory(String category) {
    final bundles = getBundles();
    return bundles.where((bundle) => bundle['category'] == category).toList();
  }

  // Get all providers
  static List<Map<String, dynamic>> getProviders() {
    return List<Map<String, dynamic>>.from(_data?['providers'] ?? []);
  }

  // Get available providers
  static List<Map<String, dynamic>> getAvailableProviders() {
    final providers = getProviders();
    return providers.where((provider) => provider['isAvailable'] == true).toList();
  }

  // Get provider by ID
  static Map<String, dynamic>? getProviderById(String id) {
    final providers = getProviders();
    try {
      return providers.firstWhere((provider) => provider['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // Get providers by service type
  static List<Map<String, dynamic>> getProvidersByService(String serviceType) {
    final providers = getProviders();
    return providers.where((provider) {
      final services = List<String>.from(provider['services'] ?? []);
      return services.contains(serviceType);
    }).toList();
  }

  // Get all client feedback
  static List<Map<String, dynamic>> getClientFeedback() {
    return List<Map<String, dynamic>>.from(_data?['clientFeedback'] ?? []);
  }

  // Get feedback by provider ID
  static List<Map<String, dynamic>> getFeedbackByProvider(String providerId) {
    final feedback = getClientFeedback();
    return feedback.where((item) => item['providerId'] == providerId).toList();
  }

  // Get feedback by service type
  static List<Map<String, dynamic>> getFeedbackByService(String serviceType) {
    final feedback = getClientFeedback();
    return feedback.where((item) => item['serviceType'] == serviceType).toList();
  }

  // Get all categories
  static List<Map<String, dynamic>> getCategories() {
    return List<Map<String, dynamic>>.from(_data?['categories'] ?? []);
  }

  // Get category by ID
  static Map<String, dynamic>? getCategoryById(String id) {
    final categories = getCategories();
    try {
      return categories.firstWhere((category) => category['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // Get user profile
  static Map<String, dynamic>? getUserProfile() {
    return _data?['userProfile'];
  }

  // Get user's joined bundles
  static List<Map<String, dynamic>> getUserJoinedBundles() {
    final userProfile = getUserProfile();
    if (userProfile == null) return [];
    
    final joinedBundleIds = List<String>.from(userProfile['joinedBundles'] ?? []);
    final allBundles = getBundles();
    
    return allBundles.where((bundle) => 
        joinedBundleIds.contains(bundle['id'])).toList();
  }

  // Get user's favorite providers
  static List<Map<String, dynamic>> getUserFavoriteProviders() {
    final userProfile = getUserProfile();
    if (userProfile == null) return [];
    
    final favoriteProviderIds = List<String>.from(userProfile['favoriteProviders'] ?? []);
    final allProviders = getProviders();
    
    return allProviders.where((provider) => 
        favoriteProviderIds.contains(provider['id'])).toList();
  }

  // Get user's service history
  static List<Map<String, dynamic>> getUserServiceHistory() {
    final userProfile = getUserProfile();
    if (userProfile == null) return [];
    
    return List<Map<String, dynamic>>.from(userProfile['serviceHistory'] ?? []);
  }

  // Get app settings
  static Map<String, dynamic>? getAppSettings() {
    return _data?['appSettings'];
  }

  // Get notifications
  static List<Map<String, dynamic>> getNotifications() {
    return List<Map<String, dynamic>>.from(_data?['notifications'] ?? []);
  }

  // Get unread notifications
  static List<Map<String, dynamic>> getUnreadNotifications() {
    final notifications = getNotifications();
    return notifications.where((notif) => notif['isRead'] == false).toList();
  }

  // Get locations
  static List<Map<String, dynamic>> getLocations() {
    return List<Map<String, dynamic>>.from(_data?['locations'] ?? []);
  }

  // Search services by query
  static List<Map<String, dynamic>> searchServices(String query) {
    final services = getServices();
    final lowercaseQuery = query.toLowerCase();
    
    return services.where((service) {
      final title = service['title']?.toString().toLowerCase() ?? '';
      final description = service['description']?.toString().toLowerCase() ?? '';
      final category = service['category']?.toString().toLowerCase() ?? '';
      
      return title.contains(lowercaseQuery) || 
             description.contains(lowercaseQuery) || 
             category.contains(lowercaseQuery);
    }).toList();
  }

  // Search providers by query
  static List<Map<String, dynamic>> searchProviders(String query) {
    final providers = getProviders();
    final lowercaseQuery = query.toLowerCase();
    
    return providers.where((provider) {
      final name = provider['name']?.toString().toLowerCase() ?? '';
      final specialties = List<String>.from(provider['specialties'] ?? [])
          .map((s) => s.toLowerCase()).join(' ');
      
      return name.contains(lowercaseQuery) || 
             specialties.contains(lowercaseQuery);
    }).toList();
  }

  // Get average rating for a provider
  static double getProviderAverageRating(String providerId) {
    final feedback = getFeedbackByProvider(providerId);
    if (feedback.isEmpty) return 0.0;
    
    final totalRating = feedback.fold<double>(0.0, (sum, item) => 
        sum + (item['rating']?.toDouble() ?? 0.0));
    
    return totalRating / feedback.length;
  }

  // Get total review count for a provider
  static int getProviderReviewCount(String providerId) {
    return getFeedbackByProvider(providerId).length;
  }

  // Check if user has joined a bundle
  static bool hasUserJoinedBundle(String bundleId) {
    final userProfile = getUserProfile();
    if (userProfile == null) return false;
    
    final joinedBundleIds = List<String>.from(userProfile['joinedBundles'] ?? []);
    return joinedBundleIds.contains(bundleId);
  }

  // Add bundle to user's joined bundles (simulate API call)
  static Future<bool> joinBundle(String bundleId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In a real app, this would make an API call
    // For now, we'll just return true to simulate success
    return true;
  }

  // Remove bundle from user's joined bundles (simulate API call)
  static Future<bool> leaveBundle(String bundleId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In a real app, this would make an API call
    // For now, we'll just return true to simulate success
    return true;
  }

  // Submit service request (simulate API call)
  static Future<Map<String, dynamic>> submitServiceRequest({
    required String serviceId,
    required String providerId,
    required String problem,
    required String note,
    required DateTime date,
    required String time,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate random success/failure
    final random = DateTime.now().millisecondsSinceEpoch % 10;
    final isSuccess = random < 7; // 70% success rate
    
    return {
      'success': isSuccess,
      'requestId': 'req_${DateTime.now().millisecondsSinceEpoch}',
      'message': isSuccess 
          ? 'Service request submitted successfully' 
          : 'Service request failed - provider unavailable',
      'estimatedResponseTime': '10 minutes',
    };
  }

  // Get service request status
  static Future<Map<String, dynamic>> getServiceRequestStatus(String requestId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return {
      'requestId': requestId,
      'status': 'pending', // pending, accepted, in_progress, completed, cancelled
      'providerId': '1',
      'estimatedArrival': '2024-01-20T15:30:00Z',
      'message': 'Provider is on the way',
    };
  }
}
