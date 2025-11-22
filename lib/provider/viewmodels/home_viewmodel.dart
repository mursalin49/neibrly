import 'package:flutter/foundation.dart';
import '../models/provider_profile.dart';
import '../models/service_request.dart';
import '../models/analytics.dart';
import '../models/client_feedback.dart';

class HomeViewModel extends ChangeNotifier {
  ProviderProfile _providerProfile = ProviderProfile.demo();
  List<ServiceRequest> _activeRequests = [];
  List<ServiceRequest> _acceptedRequests = [];
  Analytics _analytics = Analytics.demo();
  List<ClientFeedback> _allClientFeedback = ClientFeedback.demo();
  List<ClientFeedback> _clientFeedback = [];
  int _currentPhase = 0; // 0: detailed pending, 1: team pending, 2: accepted list
  int _feedbackPage = 0;
  static const int _feedbackPageSize = 3;

  // Getters
  ProviderProfile get providerProfile => _providerProfile;
  List<ServiceRequest> get activeRequests => _activeRequests;
  List<ServiceRequest> get acceptedRequests => _acceptedRequests;
  Analytics get analytics => _analytics;
  List<ClientFeedback> get clientFeedback => _clientFeedback;
  int get currentPhase => _currentPhase;

  HomeViewModel() {
    _initializeData();
  }

  void _initializeData() {
    // Initialize with different phases based on current state
    _loadPhaseData();
    _loadFeedbackPage();
  }

  void _loadPhaseData() {
    // For demo purposes, we'll show incoming requests first
    // In real app, this would be determined by actual data
    _activeRequests = [ServiceRequest.demoApplianceRepair()];
    _acceptedRequests = [
      ServiceRequest.demoAccepted(),
      ServiceRequest.demoAcceptedAppliance1(),
      ServiceRequest.demoAcceptedAppliance2(),
      ServiceRequest.demoAcceptedPlumbing(),
      ServiceRequest.demoAcceptedElectrical(),
      ServiceRequest.demoAcceptedCleaning(),
      ServiceRequest.demoAcceptedWindow2(),
    ];
    notifyListeners();
  }

  // Method to simulate no incoming requests (for testing the other layout)
  void setNoIncomingRequests() {
    _activeRequests = [];
    notifyListeners();
  }

  // Method to simulate incoming requests (for testing the first layout)
  void setIncomingRequests() {
    _activeRequests = [ServiceRequest.demoApplianceRepair()];
    notifyListeners();
  }

  void switchToPhase(int phase) {
    if (phase >= 0 && phase <= 2) {
      _currentPhase = phase;
      _loadPhaseData();
    }
  }

  void acceptRequest(String requestId) {
    final requestIndex = _activeRequests.indexWhere((req) => req.id == requestId);
    if (requestIndex != -1) {
      // Update request status to accepted
      final updatedRequest = ServiceRequest(
        id: _activeRequests[requestIndex].id,
        serviceType: _activeRequests[requestIndex].serviceType,
        serviceName: _activeRequests[requestIndex].serviceName,
        pricePerHour: _activeRequests[requestIndex].pricePerHour,
        clientName: _activeRequests[requestIndex].clientName,
        clientImage: _activeRequests[requestIndex].clientImage,
        clientRating: _activeRequests[requestIndex].clientRating,
        clientReviewCount: _activeRequests[requestIndex].clientReviewCount,
        address: _activeRequests[requestIndex].address,
        date: _activeRequests[requestIndex].date,
        time: _activeRequests[requestIndex].time,
        problemNote: _activeRequests[requestIndex].problemNote,
        status: RequestStatus.accepted,
        isTeamService: _activeRequests[requestIndex].isTeamService,
        teamMembers: _activeRequests[requestIndex].teamMembers,
        bundleType: _activeRequests[requestIndex].bundleType,
      );
      
      _activeRequests[requestIndex] = updatedRequest;
      notifyListeners();
    }
  }

  void cancelRequest(String requestId) {
    _activeRequests.removeWhere((req) => req.id == requestId);
    notifyListeners();
  }

  void _loadFeedbackPage() {
    final startIndex = 0;
    final endIndex = ((_feedbackPage + 1) * _feedbackPageSize).clamp(0, _allClientFeedback.length);
    
    if (startIndex < _allClientFeedback.length) {
      _clientFeedback = _allClientFeedback.sublist(startIndex, endIndex);
    }
    notifyListeners();
  }

  void loadMoreFeedback() {
    _feedbackPage++;
    _loadFeedbackPage();
  }

  bool get hasMoreFeedback {
    final currentCount = (_feedbackPage + 1) * _feedbackPageSize;
    return currentCount < _allClientFeedback.length;
  }

  void toggleFeedbackExpansion(String feedbackId) {
    final feedbackIndex = _clientFeedback.indexWhere((fb) => fb.id == feedbackId);
    if (feedbackIndex != -1) {
      final feedback = _clientFeedback[feedbackIndex];
      _clientFeedback[feedbackIndex] = ClientFeedback(
        id: feedback.id,
        clientName: feedback.clientName,
        clientImage: feedback.clientImage,
        rating: feedback.rating,
        comment: feedback.comment,
        date: feedback.date,
        isExpanded: !feedback.isExpanded,
      );
      notifyListeners();
    }
  }
}
