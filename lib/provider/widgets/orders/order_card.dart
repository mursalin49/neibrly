import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../colors.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Service image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: KoreColors.lightGreen,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  order.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: KoreColors.lightGreen,
                      child: Icon(
                        _getServiceIcon(order.serviceName),
                        color: KoreColors.container1,
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Order details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service name
                  Text(
                    order.serviceName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  
                  // Average price
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Avg. price: ',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: KoreColors.textLight,
                          ),
                        ),
                        TextSpan(
                          text: '\$${order.averagePrice.toInt()}/hr',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF0E7A60),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  
                  // Date and time
                  Text(
                    'Date: ${order.formattedDate}, ${order.time}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: KoreColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            
            // Status tag
            _buildStatusTag(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTag(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color dotColor;
    
    switch (order.status) {
      case OrderStatus.pending:
        backgroundColor = const Color(0xFFFFF4E6); // Light orange
        textColor = const Color(0xFFE65100); // Dark orange
        dotColor = const Color(0xFFE65100); // Dark orange
        break;
      case OrderStatus.accepted:
        backgroundColor = const Color(0xFFE8F5E8); // Light green
        textColor = const Color(0xFF0E7A60); // Dark green
        dotColor = const Color(0xFF0E7A60); // Dark green
        break;
      case OrderStatus.completed:
        backgroundColor = const Color(0xFFE8F5E8); // Light green
        textColor = const Color(0xFF0E7A60); // Dark green
        dotColor = const Color(0xFF0E7A60); // Dark green
        break;
      case OrderStatus.cancelled:
        backgroundColor = const Color(0xFFFFEBEE); // Light red
        textColor = const Color(0xFFD32F2F); // Dark red
        dotColor = const Color(0xFFD32F2F); // Dark red
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            order.statusText,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'appliance repairs':
        return Icons.build;
      case 'house cleaning':
        return Icons.cleaning_services;
      case 'plumbing':
        return Icons.plumbing;
      case 'electrical':
        return Icons.electrical_services;
      case 'window washing':
        return Icons.cleaning_services;
      default:
        return Icons.work;
    }
  }
}
