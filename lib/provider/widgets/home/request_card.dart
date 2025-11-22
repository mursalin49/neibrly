import 'package:flutter/material.dart';
import '../../models/service_request.dart';
import '../colors.dart';
import '../button.dart';

class RequestCard extends StatelessWidget {
  final ServiceRequest request;
  final VoidCallback? onAccept;
  final VoidCallback? onCancel;

  const RequestCard({
    super.key,
    required this.request,
    this.onAccept,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    if (request.status == RequestStatus.accepted) {
      return _buildAcceptedCard(context);
    } else if (request.isTeamService) {
      return _buildTeamPendingCard(context);
    } else {
      return _buildDetailedPendingCard(context);
    }
  }

  Widget _buildDetailedPendingCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x080E7A60), // 3% opacity of #0E7A60
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0x4D0E7A60), // 30% opacity of #0E7A60
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service type and price
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                request.serviceName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: KoreColors.textDark,
                ),
              ),
              Text(
                " : ",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: KoreColors.textDark,
                ),
              ),
              Text(
                '\$${request.pricePerHour.toInt()}/hr',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0E7A60),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Client info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(request.clientImage),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.clientName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: KoreColors.textDark,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.black, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${request.clientRating} (${request.clientReviewCount} reviews)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Address
          Row(
            children: [
              //const Icon(Icons.location_on, color: KoreColors.textLight, size: 16),
              //const SizedBox(width: 4),
              Text(
                'Address: ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: KoreColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  request.address,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: KoreColors.textLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Date and time
          Row(
            children: [
              Text(
                'Date: ${_formatDate(request.date)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: KoreColors.textLight,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Time: ${request.time}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: KoreColors.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Problem note
          if (request.problemNote != null) ...[
            Text(
              'Problem Note for Fridge Repair',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: KoreColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              request.problemNote!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: KoreColors.textLight,
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: KoreButton(
                  text: 'Decline',
                  onPressed: onCancel ?? () {},
                  isPrimary: false,
                  isCancel: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: KoreButton(
                  text: 'Accept',
                  onPressed: onAccept ?? () {},
                  isPrimary: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPendingCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x080E7A60), // 3% opacity of #0E7A60
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0x4D0E7A60), // 30% opacity of #0E7A60
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service type
          Text(
            request.serviceName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: KoreColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          
          // Bundle type
          Text(
            request.bundleType ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: KoreColors.textLight,
            ),
          ),
          const SizedBox(height: 12),
          
          // Team members
          Row(
            children: [
              // Overlapping avatars
              ...List.generate(3, (index) => Container(
                margin: EdgeInsets.only(left: index > 0 ? -8 : 0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: KoreColors.primary,
                  child: Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: request.teamMembers?.map((member) => Text(
                    member,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: KoreColors.textLight,
                    ),
                  )).toList() ?? [],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Date and time
          Row(
            children: [
              const Icon(Icons.calendar_today, color: KoreColors.textLight, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Date: ${_formatDate(request.date)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: KoreColors.textLight,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.access_time, color: KoreColors.textLight, size: 16),
              const SizedBox(width: 4),
              Text(
                'Time: ${request.time}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: KoreColors.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Price
          Text(
            '\$${request.pricePerHour.toInt()}/hr',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: KoreColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          
          // Accept button
          KoreButton(
            text: 'Accept',
            onPressed: onAccept ?? () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptedCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: KoreColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Service image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                _getServiceImage(request.serviceType),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if image fails to load
                  return Container(
                    color: KoreColors.lightGreen,
                    child: Icon(
                      request.serviceType == ServiceType.windowWashing 
                          ? Icons.cleaning_services 
                          : Icons.build,
                      color: KoreColors.container1,
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Service details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.serviceName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Avg. price: \$${request.pricePerHour.toInt()}/hr',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: KoreColors.textLight,
                        ),
                      ),
                    ),
                    if (request.isTeamService) ...[
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/people.svg',
                        width: 14,
                        height: 14,
                        color: KoreColors.textLight,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback to icon if SVG fails to load
                          return const Icon(
                            Icons.people,
                            color: KoreColors.textLight,
                            size: 14,
                          );
                        },
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Date: ${_formatDateShort(request.date)}, ${request.time}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: KoreColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          
          // Accepted tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: KoreColors.lightGreen,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: KoreColors.container1,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Accepted',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: KoreColors.container1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _formatDateShort(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _getServiceImage(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.windowWashing:
      case ServiceType.cleaning:
        return 'assets/images/cleaning.png';
      case ServiceType.applianceRepairs:
      case ServiceType.plumbing:
      case ServiceType.electrical:
        return 'assets/images/repares.png';
    }
  }
}
