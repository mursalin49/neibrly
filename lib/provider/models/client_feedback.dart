class ClientFeedback {
  final String id;
  final String clientName;
  final String clientImage;
  final double rating;
  final String comment;
  final DateTime date;
  final bool isExpanded;

  const ClientFeedback({
    required this.id,
    required this.clientName,
    required this.clientImage,
    required this.rating,
    required this.comment,
    required this.date,
    this.isExpanded = false,
  });

  static List<ClientFeedback> demo() {
    return [
      ClientFeedback(
        id: "1",
        clientName: "Jessica R",
        clientImage: "assets/images/jessica.png",
        rating: 4.0,
        comment: "Thank you for your work! The service met my expectations and I'm very happy. The technician was professional and completed the job efficiently. I would definitely recommend this service to others.",
        date: DateTime(2025, 9, 17),
      ),
      ClientFeedback(
        id: "2",
        clientName: "Maria Gosh",
        clientImage: "assets/images/maria.png",
        rating: 2.0,
        comment: "Service was okay but could be better. The technician arrived late and the work quality was average. Not sure if I would use this service again.",
        date: DateTime(2025, 8, 18),
      ),
      ClientFeedback(
        id: "3",
        clientName: "Ethan Lert",
        clientImage: "assets/images/ethan.png",
        rating: 3.0,
        comment: "Good work overall, minor issues with timing. The technician was friendly and the final result was satisfactory.",
        date: DateTime(2025, 8, 25),
      ),
      ClientFeedback(
        id: "4",
        clientName: "Sarah Johnson",
        clientImage: "assets/images/jane.png",
        rating: 5.0,
        comment: "",
        date: DateTime(2025, 8, 20),
      ),
      ClientFeedback(
        id: "5",
        clientName: "Mike Wilson",
        clientImage: "assets/images/ethan.png",
        rating: 4.0,
        comment: "Excellent service! Very professional and quick. The technician explained everything clearly and the work was done perfectly. Highly recommended!",
        date: DateTime(2025, 8, 15),
      ),
      ClientFeedback(
        id: "6",
        clientName: "Lisa Brown",
        clientImage: "assets/images/maria.png",
        rating: 1.0,
        comment: "",
        date: DateTime(2025, 8, 10),
      ),
    ];
  }
}
