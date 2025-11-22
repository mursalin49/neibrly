import 'package:flutter/material.dart';

class MyServicesSection extends StatelessWidget {
  const MyServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Services",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            ServiceTag("1. Window Washing"),
            ServiceTag("2. Plumbing"),
            ServiceTag("3. Locksmiths"),
            ServiceTag("4. Appliance Repairs"),
            ServiceTag("5. Door & Window Repairs"),
          ],
        ),
      ],
    );
  }
}

class ServiceTag extends StatelessWidget {
  final String label;
  const ServiceTag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
