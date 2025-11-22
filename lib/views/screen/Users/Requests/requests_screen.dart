import 'package:flutter/material.dart';
import 'package:naibrly/models/user_request.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/widgets/request_filter_tabs.dart';
import 'package:naibrly/widgets/user_request_card.dart';
import 'package:naibrly/views/screen/Users/Request/user_request_inbox_screen.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  RequestFilter currentFilter = RequestFilter.open;
  List<UserRequest> allRequests = [];
  List<UserRequest> filteredRequests = [];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  void _loadRequests() {
    setState(() {
      allRequests = UserRequest.getAllDemoRequests();
      _filterRequests();
    });
  }

  void _filterRequests() {
    setState(() {
      switch (currentFilter) {
        case RequestFilter.open:
          filteredRequests = allRequests.where((r) => 
            r.status == RequestStatus.pending || r.status == RequestStatus.accepted
          ).toList();
          break;
        case RequestFilter.closed:
          filteredRequests = allRequests.where((r) => 
            r.status == RequestStatus.cancelled || r.status == RequestStatus.done
          ).toList();
          break;
      }
    });
  }

  void _onFilterChanged(RequestFilter filter) {
    setState(() {
      currentFilter = filter;
    });
    _filterRequests();
  }

  int _getOpenCount() {
    return allRequests.where((r) => 
      r.status == RequestStatus.pending || r.status == RequestStatus.accepted
    ).length;
  }

  int _getClosedCount() {
    return allRequests.where((r) => 
      r.status == RequestStatus.cancelled || r.status == RequestStatus.done
    ).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        elevation: 0,
        title: AppText(
          'My Requests',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.Black,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Filter tabs
          RequestFilterTabs(
            currentFilter: currentFilter,
            onFilterChanged: _onFilterChanged,
            openCount: _getOpenCount(),
            closedCount: _getClosedCount(),
          ),
          
          // Requests list
          Expanded(
            child: filteredRequests.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return UserRequestCard(
                        request: request,
                        onTap: () => _showRequestDetails(context, request),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: AppColors.DarkGray.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          AppText(
            'No requests found',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.DarkGray,
          ),
          const SizedBox(height: 4),
          AppText(
            'You don\'t have any ${_getCurrentFilterText()} requests yet',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.DarkGray,
          ),
        ],
      ),
    );
  }

  String _getCurrentFilterText() {
    switch (currentFilter) {
      case RequestFilter.open:
        return 'open';
      case RequestFilter.closed:
        return 'closed';
    }
  }

  void _showRequestDetails(BuildContext context, UserRequest request) {
    // Navigate to inbox screen for all requests
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserRequestInboxScreen(request: request),
      ),
    );
  }
}