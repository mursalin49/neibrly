class ProviderProfile {
  final String name;
  final double rating;
  final int reviewCount;
  final double earnings;
  final bool isOnline;

  const ProviderProfile({
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.earnings,
    this.isOnline = true,
  });

  factory ProviderProfile.demo() {
    return const ProviderProfile(
      name: "Jacob Maicle",
      rating: 5.0,
      reviewCount: 1513,
      earnings: 5892.0,
      isOnline: true,
    );
  }
}
