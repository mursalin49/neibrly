import 'package:flutter/material.dart';

enum OrderStatus { pending, accepted, completed, cancelled }

class Order {
  final String id;
  final String serviceName;
  final double averagePrice;
  final DateTime date;
  final String time;
  final String imagePath;
  final OrderStatus status;
  final String? problemDescription;
  final String clientName;
  final String clientImage;
  final double clientRating;
  final int clientReviewCount;
  final String address;
  final bool isTeamService;
  final List<String>? teamMembers;
  final String? bundleType;

  const Order({
    required this.id,
    required this.serviceName,
    required this.averagePrice,
    required this.date,
    required this.time,
    required this.imagePath,
    required this.status,
    this.problemDescription,
    required this.clientName,
    required this.clientImage,
    required this.clientRating,
    required this.clientReviewCount,
    required this.address,
    this.isTeamService = false,
    this.teamMembers,
    this.bundleType,
  });

  // Demo data factories
  factory Order.demoPendingAppliance() {
    return Order(
      id: "1",
      serviceName: "Appliance Repairs",
      averagePrice: 63.0,
      date: DateTime(2025, 9, 18),
      time: "14:00",
      imagePath: "assets/images/repares.png",
      status: OrderStatus.pending,
      problemDescription: "Dishwasher not draining properly, making strange noises",
      clientName: "Sarah Johnson",
      clientImage: "assets/images/jane.png",
      clientRating: 4.8,
      clientReviewCount: 42,
      address: "123 Oak Street, Springfield, IL 62704",
    );
  }

  factory Order.demoAcceptedAppliance() {
    return Order(
      id: "2",
      serviceName: "Appliance Repairs",
      averagePrice: 63.0,
      date: DateTime(2025, 9, 18),
      time: "14:00",
      imagePath: "assets/images/repares.png",
      status: OrderStatus.accepted,
      problemDescription: "Washing machine not spinning, water leaking",
      clientName: "Mike Wilson",
      clientImage: "assets/images/ethan.png",
      clientRating: 4.2,
      clientReviewCount: 18,
      address: "456 Pine Street, Springfield, IL 62704",
    );
  }

  factory Order.demoAcceptedCleaning() {
    return Order(
      id: "3",
      serviceName: "House Cleaning",
      averagePrice: 45.0,
      date: DateTime(2025, 9, 17),
      time: "10:30",
      imagePath: "assets/images/cleaning.png",
      status: OrderStatus.accepted,
      problemDescription: "Deep cleaning required for 3-bedroom house",
      clientName: "Lisa Brown",
      clientImage: "assets/images/maria.png",
      clientRating: 4.6,
      clientReviewCount: 31,
      address: "789 Elm Street, Springfield, IL 62704",
      isTeamService: true,
      bundleType: "2-Person Team",
      teamMembers: ["Emma Davis", "John Miller"],
    );
  }

  factory Order.demoPendingPlumbing() {
    return Order(
      id: "4",
      serviceName: "Plumbing",
      averagePrice: 75.0,
      date: DateTime(2025, 9, 16),
      time: "09:00",
      imagePath: "assets/images/repares.png",
      status: OrderStatus.pending,
      problemDescription: "Kitchen sink clogged, water backing up",
      clientName: "David Smith",
      clientImage: "assets/images/jessica.png",
      clientRating: 4.9,
      clientReviewCount: 67,
      address: "147 Pine Street, Springfield, IL 62704",
    );
  }

  factory Order.demoAcceptedElectrical() {
    return Order(
      id: "5",
      serviceName: "Electrical",
      averagePrice: 85.0,
      date: DateTime(2025, 9, 15),
      time: "16:00",
      imagePath: "assets/images/repares.png",
      status: OrderStatus.accepted,
      problemDescription: "Outdoor lighting installation needed",
      clientName: "Alex Thompson",
      clientImage: "assets/images/ethan.png",
      clientRating: 4.4,
      clientReviewCount: 15,
      address: "258 Oak Drive, Springfield, IL 62704",
    );
  }

  factory Order.demoCompletedWindow() {
    return Order(
      id: "6",
      serviceName: "Window Washing",
      averagePrice: 50.0,
      date: DateTime(2025, 9, 14),
      time: "11:00",
      imagePath: "assets/images/cleaning.png",
      status: OrderStatus.completed,
      problemDescription: "Exterior window cleaning for 2-story house",
      clientName: "Maria Garcia",
      clientImage: "assets/images/maria.png",
      clientRating: 4.7,
      clientReviewCount: 28,
      address: "369 Walnut Street, Springfield, IL 62704",
      isTeamService: true,
      bundleType: "2-Person Team",
      teamMembers: ["John Miller", "Sarah Wilson"],
    );
  }

  factory Order.demoCancelledCleaning() {
    return Order(
      id: "7",
      serviceName: "House Cleaning",
      averagePrice: 45.0,
      date: DateTime(2025, 9, 13),
      time: "14:30",
      imagePath: "assets/images/cleaning.png",
      status: OrderStatus.cancelled,
      problemDescription: "Office cleaning service",
      clientName: "Robert Davis",
      clientImage: "assets/images/jane.png",
      clientRating: 4.1,
      clientReviewCount: 12,
      address: "741 Cedar Lane, Springfield, IL 62704",
    );
  }

  // Static method to get all demo orders
  static List<Order> getAllDemoOrders() {
    return [
      Order.demoPendingAppliance(),
      Order.demoAcceptedAppliance(),
      Order.demoAcceptedCleaning(),
      Order.demoPendingPlumbing(),
      Order.demoAcceptedElectrical(),
      Order.demoCompletedWindow(),
      Order.demoCancelledCleaning(),
    ];
  }

  // Helper methods
  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.accepted:
        return 'Accepted';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get statusColor {
    switch (status) {
      case OrderStatus.pending:
        return const Color(0xFFFF6B35); // Orange
      case OrderStatus.accepted:
        return const Color(0xFF0E7A60); // Green
      case OrderStatus.completed:
        return const Color(0xFF4CAF50); // Light Green
      case OrderStatus.cancelled:
        return const Color(0xFFF44336); // Red
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
