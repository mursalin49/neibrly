enum RequestStatus { pending, accepted, cancelled, completed }
enum ServiceType { applianceRepairs, windowWashing, plumbing, electrical, cleaning }

class ServiceRequest {
  final String id;
  final ServiceType serviceType;
  final String serviceName;
  final double pricePerHour;
  final String clientName;
  final String clientImage;
  final double clientRating;
  final int clientReviewCount;
  final String address;
  final DateTime date;
  final String time;
  final String? problemNote;
  final RequestStatus status;
  final bool isTeamService;
  final List<String>? teamMembers;
  final String? bundleType;

  const ServiceRequest({
    required this.id,
    required this.serviceType,
    required this.serviceName,
    required this.pricePerHour,
    required this.clientName,
    required this.clientImage,
    required this.clientRating,
    required this.clientReviewCount,
    required this.address,
    required this.date,
    required this.time,
    this.problemNote,
    required this.status,
    this.isTeamService = false,
    this.teamMembers,
    this.bundleType,
  });

  factory ServiceRequest.demoApplianceRepair() {
    return ServiceRequest(
      id: "1",
      serviceType: ServiceType.applianceRepairs,
      serviceName: "Appliance Repairs",
      pricePerHour: 63.0,
      clientName: "Jane Doe",
      clientImage: "assets/images/jane.png",
      clientRating: 5.0,
      clientReviewCount: 55,
      address: "123 Oak Street Springfield, IL 62704",
      date: DateTime(2025, 9, 18),
      time: "14:00",
      problemNote: "The fridge is not cooling properly, making strange noises, freezing food, leaking water, etc.",
      status: RequestStatus.pending,
    );
  }

  factory ServiceRequest.demoWindowWashing() {
    return ServiceRequest(
      id: "2",
      serviceType: ServiceType.windowWashing,
      serviceName: "Window Washing",
      pricePerHour: 55.0,
      address: "456 Pine Street Springfield, IL 62704",
      date: DateTime(2025, 9, 18),
      time: "14:00",
      status: RequestStatus.pending,
      isTeamService: true,
      bundleType: "3-Person Bundle",
      teamMembers: [
        "Ethan Lert Street Springfield, IL 62704",
        "Ethan Lert Street Springfield, IL 62704",
        "Ethan Lert Street Springfield, IL 62704"
      ],
      clientName: "Window Cleaning Co",
      clientImage: "assets/images/ethan.png",
      clientRating: 4.5,
      clientReviewCount: 23,
    );
  }

  factory ServiceRequest.demoAccepted() {
    return ServiceRequest(
      id: "3",
      serviceType: ServiceType.windowWashing,
      serviceName: "Window Washing",
      pricePerHour: 55.0,
      address: "789 Elm Street Springfield, IL 62704",
      date: DateTime(2025, 9, 18),
      time: "14:00",
      status: RequestStatus.accepted,
      isTeamService: true,
      clientName: "Window Cleaning Co",
      clientImage: "assets/images/ethan.png",
      clientRating: 4.5,
      clientReviewCount: 23,
    );
  }

  factory ServiceRequest.demoAcceptedAppliance1() {
    return ServiceRequest(
      id: "4",
      serviceType: ServiceType.applianceRepairs,
      serviceName: "Appliance Repairs",
      pricePerHour: 63.0,
      address: "321 Maple Avenue Springfield, IL 62704",
      date: DateTime(2025, 9, 18),
      time: "14:00",
      status: RequestStatus.accepted,
      isTeamService: false,
      clientName: "Sarah Johnson",
      clientImage: "assets/images/jane.png",
      clientRating: 4.8,
      clientReviewCount: 42,
    );
  }

  factory ServiceRequest.demoAcceptedAppliance2() {
    return ServiceRequest(
      id: "5",
      serviceType: ServiceType.applianceRepairs,
      serviceName: "Appliance Repairs",
      pricePerHour: 63.0,
      address: "654 Cedar Lane Springfield, IL 62704",
      date: DateTime(2025, 9, 18),
      time: "14:00",
      status: RequestStatus.accepted,
      isTeamService: false,
      clientName: "Mike Wilson",
      clientImage: "assets/images/ethan.png",
      clientRating: 4.2,
      clientReviewCount: 18,
    );
  }

  factory ServiceRequest.demoAcceptedPlumbing() {
    return ServiceRequest(
      id: "6",
      serviceType: ServiceType.plumbing,
      serviceName: "Plumbing",
      pricePerHour: 75.0,
      address: "987 Birch Street Springfield, IL 62704",
      date: DateTime(2025, 9, 17),
      time: "10:30",
      status: RequestStatus.accepted,
      isTeamService: false,
      clientName: "Lisa Brown",
      clientImage: "assets/images/maria.png",
      clientRating: 4.6,
      clientReviewCount: 31,
    );
  }

  factory ServiceRequest.demoAcceptedElectrical() {
    return ServiceRequest(
      id: "7",
      serviceType: ServiceType.electrical,
      serviceName: "Electrical",
      pricePerHour: 85.0,
      address: "147 Pine Street Springfield, IL 62704",
      date: DateTime(2025, 9, 16),
      time: "09:00",
      status: RequestStatus.accepted,
      isTeamService: false,
      clientName: "David Smith",
      clientImage: "assets/images/jessica.png",
      clientRating: 4.9,
      clientReviewCount: 67,
    );
  }

  factory ServiceRequest.demoAcceptedCleaning() {
    return ServiceRequest(
      id: "8",
      serviceType: ServiceType.cleaning,
      serviceName: "House Cleaning",
      pricePerHour: 45.0,
      address: "258 Oak Drive Springfield, IL 62704",
      date: DateTime(2025, 9, 15),
      time: "16:00",
      status: RequestStatus.accepted,
      isTeamService: true,
      bundleType: "2-Person Team",
      teamMembers: [
        "Emma Davis",
        "John Miller"
      ],
      clientName: "Emma Davis",
      clientImage: "assets/images/jane.png",
      clientRating: 4.7,
      clientReviewCount: 28,
    );
  }

  factory ServiceRequest.demoAcceptedWindow2() {
    return ServiceRequest(
      id: "9",
      serviceType: ServiceType.windowWashing,
      serviceName: "Window Washing",
      pricePerHour: 50.0,
      address: "369 Walnut Street Springfield, IL 62704",
      date: DateTime(2025, 9, 14),
      time: "11:00",
      status: RequestStatus.accepted,
      isTeamService: true,
      bundleType: "2-Person Team",
      teamMembers: [
        "Alex Thompson",
        "Maria Garcia"
      ],
      clientName: "Alex Thompson",
      clientImage: "assets/images/ethan.png",
      clientRating: 4.4,
      clientReviewCount: 15,
    );
  }
}
