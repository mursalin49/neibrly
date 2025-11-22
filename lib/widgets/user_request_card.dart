import 'package:flutter/material.dart';
import 'package:naibrly/models/user_request.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';

class UserRequestCard extends StatelessWidget {
  final UserRequest request;
  final VoidCallback? onTap;

  const UserRequestCard({
    super.key,
    required this.request,
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
                color: AppColors.LightGray,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  request.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.LightGray,
                      child: Icon(
                        _getServiceIcon(request.serviceName),
                        color: AppColors.DarkGray,
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Request details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service name
                  AppText(
                    request.serviceName,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.Black,
                  ),
                  const SizedBox(height: 2),
                  
                  // Average price
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Avg. price: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.DarkGray,
                          ),
                        ),
                        TextSpan(
                          text: '\$${request.averagePrice.toInt()}/hr',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  
                  // Date and time
                  AppText(
                    'Date: ${request.formattedDate}, ${request.time}',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.DarkGray,
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
    
    switch (request.status) {
      case RequestStatus.pending:
        backgroundColor = const Color(0xFFFFF4E6); // Light orange
        textColor = const Color(0xFFE65100); // Dark orange
        dotColor = const Color(0xFFE65100); // Dark orange
        break;
      case RequestStatus.accepted:
        backgroundColor = const Color(0xFFE8F5E8); // Light green
        textColor = const Color(0xFF0E7A60); // Dark green
        dotColor = const Color(0xFF0E7A60); // Dark green
        break;
      case RequestStatus.done:
        backgroundColor = const Color(0xFFE8F5E8); // Light green
        textColor = const Color(0xFF0E7A60); // Dark green
        dotColor = const Color(0xFF0E7A60); // Dark green
        break;
      case RequestStatus.cancelled:
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
          AppText(
            request.statusText,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: textColor,
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
