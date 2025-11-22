import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/home/provider_header.dart';
import '../../widgets/home/request_card.dart';
import '../../widgets/home/analytics_section.dart';
import '../../widgets/home/client_feedback_section.dart';
import '../../widgets/home/bottom_navigation.dart';
import '../../widgets/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: KoreColors.background,
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Column(
                children: [
                  // Main content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Provider header
                          ProviderHeader(profile: viewModel.providerProfile),
                          
                          // Conditional layout based on active requests
                          if (viewModel.activeRequests.isNotEmpty) ...[
                            // Active requests section (if there are incoming requests)
                            _buildActiveRequestsSection(viewModel),
                            
                            // Analytics section
                            AnalyticsSection(analytics: viewModel.analytics),
                          ] else ...[
                            // Analytics section first (if no incoming requests)
                            AnalyticsSection(analytics: viewModel.analytics),
                            
                            // Accepted requests list
                            _buildAcceptedRequestsSection(viewModel),
                          ],
                          
                          // Client feedback section
                          ClientFeedbackSection(
                            feedbackList: viewModel.clientFeedback,
                            onToggleExpansion: (feedbackId) {
                              viewModel.toggleFeedbackExpansion(feedbackId);
                            },
                            onLoadMore: () {
                              viewModel.loadMoreFeedback();
                            },
                            hasMoreFeedback: viewModel.hasMoreFeedback,
                          ),
                          
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAcceptedRequestsSection(HomeViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Accepted Requests',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: KoreColors.textDark,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (viewModel.acceptedRequests.isEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'No accepted requests',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KoreColors.textLight,
                  ),
                ),
              ),
            )
          else
            ...viewModel.acceptedRequests.map((request) => RequestCard(
              request: request,
              onAccept: () => viewModel.acceptRequest(request.id),
              onCancel: () => viewModel.cancelRequest(request.id),
            )),
        ],
      ),
    );
  }

  Widget _buildActiveRequestsSection(HomeViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Active Requests',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: KoreColors.textDark,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (viewModel.activeRequests.isEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'No active requests',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KoreColors.textLight,
                  ),
                ),
              ),
            )
          else
            ...viewModel.activeRequests.map((request) => RequestCard(
              request: request,
              onAccept: () => viewModel.acceptRequest(request.id),
              onCancel: () => viewModel.cancelRequest(request.id),
            )),
        ],
      ),
    );
  }

}
