import 'package:flutter/material.dart';

enum RequestStatus { pending, accepted, cancelled, done }

class UserRequest {
  final String id;
  final String serviceName;
  final double averagePrice;
  final DateTime date;
  final String time;
  final String imagePath;
  final RequestStatus status;
  final String? problemDescription;
  final String providerName;
  final String providerImage;
  final double providerRating;
  final int providerReviewCount;
  final String address;
  final bool isTeamService;
  final List<String>? teamMembers;
  final String? bundleType;
  final String? cancellationReason;
  final DateTime? cancellationTime;

  const UserRequest({
    required this.id,
    required this.serviceName,
    required this.averagePrice,
    required this.date,
    required this.time,
    required this.imagePath,
    required this.status,
    this.problemDescription,
    required this.providerName,
    required this.providerImage,
    required this.providerRating,
    required this.providerReviewCount,
    required this.address,
    this.isTeamService = false,
    this.teamMembers,
    this.bundleType,
    this.cancellationReason,
    this.cancellationTime,
  });

  // Demo data factories
  factory UserRequest.demoPendingAppliance() {
    return UserRequest(
      id: "1",
      serviceName: "Appliance Repairs",
      averagePrice: 63.0,
      date: DateTime(2025, 1, 18),
      time: "14:00",
      imagePath: "assets/images/repares.png",
      status: RequestStatus.pending,
      problemDescription: "Dishwasher not draining properly, making strange noises",
      providerName: "Mike's Repair Service",
      providerImage: "assets/images/jane.png",
      providerRating: 4.8,
      providerReviewCount: 42,
      address: "123 Oak Street, Springfield, IL 62704",
    );
  }

  factory UserRequest.demoAcceptedAppliance() {
    return UserRequest(
      id: "2",
      serviceName: "Appliance Repairs",
      averagePrice: 63.0,
      date: DateTime(2025, 1, 17),
      time: "14:00",
      imagePath: "assets/images/repares.png",
      status: RequestStatus.accepted,
      problemDescription: "Washing machine not spinning, water leaking",
      providerName: "Quick Fix Solutions",
      providerImage: "assets/images/ethan.png",
      providerRating: 4.2,
      providerReviewCount: 18,
      address: "456 Pine Street, Springfield, IL 62704",
    );
  }

  factory UserRequest.demoCancelledCleaning() {
    return UserRequest(
      id: "3",
      serviceName: "House Cleaning",
      averagePrice: 45.0,
      date: DateTime(2025, 1, 16),
      time: "10:30",
      imagePath: "assets/images/cleaning.png",
      status: RequestStatus.cancelled,
      problemDescription: "Deep cleaning required for 3-bedroom house",
      providerName: "Clean Pro Services",
      providerImage: "assets/images/maria.png",
      providerRating: 4.6,
      providerReviewCount: 31,
      address: "789 Elm Street, Springfield, IL 62704",
      isTeamService: true,
      bundleType: "2-Person Team",
      teamMembers: ["Emma Davis", "John Miller"],
      cancellationReason: "The service was no longer required due to unforeseen circumstances.",
      cancellationTime: DateTime(2025, 1, 16, 13, 44),
    );
  }

  factory UserRequest.demoDoneWindow() {
    return UserRequest(
      id: "4",
      serviceName: "Window Washing",
      averagePrice: 50.0,
      date: DateTime(2025, 1, 15),
      time: "11:00",
      imagePath: "assets/images/cleaning.png",
      status: RequestStatus.done,
      problemDescription: "Exterior window cleaning for 2-story house",
      providerName: "Crystal Clear Windows",
      providerImage: "assets/images/maria.png",
      providerRating: 4.7,
      providerReviewCount: 28,
      address: "369 Walnut Street, Springfield, IL 62704",
      isTeamService: true,
      bundleType: "2-Person Team",
      teamMembers: ["John Miller", "Sarah Wilson"],
    );
  }

  // Static method to get all demo requests
  static List<UserRequest> getAllDemoRequests() {
    return [
      UserRequest.demoPendingAppliance(),
      UserRequest.demoAcceptedAppliance(),
      UserRequest.demoCancelledCleaning(),
      UserRequest.demoDoneWindow(),
    ];
  }

  // Helper methods
  String get statusText {
    switch (status) {
      case RequestStatus.pending:
        return 'Pending';
      case RequestStatus.accepted:
        return 'Accepted';
      case RequestStatus.cancelled:
        return 'Cancelled';
      case RequestStatus.done:
        return 'Done';
    }
  }

  Color get statusColor {
    switch (status) {
      case RequestStatus.pending:
        return const Color(0xFFFF6B35); // Orange
      case RequestStatus.accepted:
        return const Color(0xFF0E7A60); // Green
      case RequestStatus.cancelled:
        return const Color(0xFFF44336); // Red
      case RequestStatus.done:
        return const Color(0xFF4CAF50); // Light Green
    }
  }

  String get formattedDate {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}';
  }
}
