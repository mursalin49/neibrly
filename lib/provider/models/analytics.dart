class Analytics {
  final int todayOrders;
  final int monthlyOrders;
  final double todayEarnings;
  final double monthlyEarnings;

  const Analytics({
    required this.todayOrders,
    required this.monthlyOrders,
    required this.todayEarnings,
    required this.monthlyEarnings,
  });

  factory Analytics.demo() {
    return const Analytics(
      todayOrders: 5,
      monthlyOrders: 82,
      todayEarnings: 223.0,
      monthlyEarnings: 2586.0,
    );
  }
}
