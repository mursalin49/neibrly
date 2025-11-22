import 'package:flutter/material.dart';
import '../../models/analytics.dart';
import '../colors.dart';

class AnalyticsSection extends StatelessWidget {
  final Analytics analytics;

  const AnalyticsSection({
    super.key,
    required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: KoreColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  context: context,
                  title: 'My Order',
                  todayValue: '${analytics.todayOrders}',
                  monthlyValue: '${analytics.monthlyOrders}',
                  icon: Icons.work_outline,
                  color: KoreColors.textLight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAnalyticsCard(
                  context: context,
                  title: 'My Earnings',
                  todayValue: '\$${analytics.todayEarnings.toInt()}',
                  monthlyValue: '\$${analytics.monthlyEarnings.toInt()}',
                  icon: Icons.attach_money,
                  color: KoreColors.textLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard({
    required BuildContext context,
    required String title,
    required String todayValue,
    required String monthlyValue,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x0500CD49), // 2% opacity of #00CD49
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0x4D00CD49), // 30% opacity of #00CD49
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: KoreColors.textLight,
                size: 12,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: KoreColors.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Data section with divider
          Row(
            children: [
              // Today data
              Expanded(
                child: Column(
                  children: [
                    Text(
                      todayValue,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: KoreColors.textLight,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Vertical divider
              Container(
                height: 40,
                width: 1,
                color: const Color(0x4D00CD49), // 30% opacity of #00CD49
              ),
              SizedBox(width: 2),
              // This Month data
              Expanded(
                child: Column(
                  children: [
                    Text(
                      monthlyValue,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'This Month',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: KoreColors.textLight,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
