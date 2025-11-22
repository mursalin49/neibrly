import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/provider/models/client_feedback.dart';
import 'package:naibrly/provider/widgets/home/client_feedback_section.dart';
import 'package:naibrly/widgets/payment_confirmation_bottom_sheet.dart';
import 'package:naibrly/widgets/naibrly_now_bottom_sheet.dart';

class ProviderDetailsScreen extends StatefulWidget {
  final String providerName;
  final String rating;
  final String status;
  final String location;
  final String price;
  final String review;

  const ProviderDetailsScreen({
    Key? key,
    required this.providerName,
    required this.rating,
    required this.status,
    required this.location,
    required this.price,
    required this.review,
  }) : super(key: key);

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
  List<ClientFeedback> _feedbackList = [];
  bool _hasMoreFeedback = true;

  @override
  void initState() {
    super.initState();
    _loadInitialFeedback();
  }

  void _loadInitialFeedback() {
    // Load first 3 feedback items
    _feedbackList = ClientFeedback.demo().take(3).toList();
    _hasMoreFeedback = ClientFeedback.demo().length > 3;
  }

  void _loadMoreFeedback() {
    setState(() {
      final currentCount = _feedbackList.length;
      final allFeedback = ClientFeedback.demo();
      if (currentCount < allFeedback.length) {
        final nextBatch = allFeedback.skip(currentCount).take(3).toList();
        _feedbackList.addAll(nextBatch);
        _hasMoreFeedback = _feedbackList.length < allFeedback.length;
      }
    });
  }

  void _toggleFeedbackExpansion(String feedbackId) {
    setState(() {
      final feedbackIndex = _feedbackList.indexWhere((fb) => fb.id == feedbackId);
      if (feedbackIndex != -1) {
        final feedback = _feedbackList[feedbackIndex];
        _feedbackList[feedbackIndex] = ClientFeedback(
          id: feedback.id,
          clientName: feedback.clientName,
          clientImage: feedback.clientImage,
          rating: feedback.rating,
          comment: feedback.comment,
          date: feedback.date,
          isExpanded: !feedback.isExpanded,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const AppText(
          "Jacob's Profile and Services",
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider Profile Section
            _buildProviderProfile(),
            
            const SizedBox(height: 24),
            
            // Call to Action Button
            _buildCallToActionButton(),
            
            const SizedBox(height: 32),
            
            // Jacob's Services Section
            _buildServicesSection(),
            
            const SizedBox(height: 32),
            
            // Client Feedback Section
            ClientFeedbackSection(
              feedbackList: _feedbackList,
              onToggleExpansion: _toggleFeedbackExpansion,
              onLoadMore: _loadMoreFeedback,
              hasMoreFeedback: _hasMoreFeedback,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderProfile() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset('assets/images/home.png'),
          
          const SizedBox(height: 16),
          
          // Provider Name & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                widget.providerName,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0E7A60),
                ),
              ),
              const SizedBox(width: 6),
              const AppText(
                "Online Now",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0E7A60),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 18,
                color: Colors.amber,
              ),
              const SizedBox(width: 4),
              AppText(
                widget.rating,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Job Statistics
          AppText(
            "12 similar jobs done near you",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          
          const SizedBox(height: 8),
          
          // Estimated Budget
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "\$63/hr",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: " estimated budget",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Provider Testimonial
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AppText(
              "Jacob says, \"the repair person come on time, diagnosed and fixed the issue with my leaking wa...\"",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToActionButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showNaibrlyNowBottomSheet(
            context,
            serviceName: "Appliance Repairs",
            providerName: widget.providerName,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0E7A60),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const AppText(
          "Nailbrly Now",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "Jacob's Services",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        
        const SizedBox(height: 16),
        
        // Service Cards
        _buildServiceCard(
          "Appliance Repairs",
          "assets/images/appliance_repair.png",
        ),
        const SizedBox(height: 12),
        _buildServiceCard(
          "Furnace Repairs",
          "assets/images/furnace_repair.png",
        ),
        const SizedBox(height: 12),
        _buildServiceCard(
          "House Cleaning Services",
          "assets/images/cleaning_services.png",
        ),
      ],
    );
  }

  Widget _buildServiceCard(String serviceName, String imagePath) {
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
      child: Row(
        children: [
          // Service Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/cleaning.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Service Name
          Expanded(
            child: AppText(
              serviceName,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          
          // Arrow Icon
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
