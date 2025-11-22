import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../colors.dart';
import '../button.dart';
import 'cancel_order_bottom_sheet.dart';
import '../../screens/order_inbox_screen.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final Order order;
  final VoidCallback? onAccept;
  final VoidCallback? onCancel;

  const OrderDetailsBottomSheet({
    super.key,
    required this.order,
    this.onAccept,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header - Service name and price
                _buildHeader(context),
                const SizedBox(height: 20),
                
                // Client information
                _buildClientInfo(context),
                const SizedBox(height: 20),
                
                // Order details
                _buildOrderDetails(context),
                const SizedBox(height: 20),
                
                // Problem note (if exists)
                if (order.problemDescription != null) ...[
                  _buildProblemNote(context),
                  const SizedBox(height: 20),
                ],
                
                // Action buttons
                _buildActionButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          '${order.serviceName}: ',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          '\$${order.averagePrice.toInt()}/hr',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0E7A60),
          ),
        ),
      ],
    );
  }

  Widget _buildClientInfo(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(order.clientImage),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.clientName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.black,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${order.clientRating} (${order.clientReviewCount} reviews)',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Address
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Address: ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: order.address,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: KoreColors.textLight,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        
        // Date and Time
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Date: ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: KoreColors.textLight,
                ),
              ),
              TextSpan(
                text: '${order.formattedDate} ${order.date.year} ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: KoreColors.textLight,
                ),
              ),
              TextSpan(
                text: 'Time: ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: KoreColors.textLight,
                ),
              ),
              TextSpan(
                text: order.time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: KoreColors.textLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProblemNote(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Problem Note for Fridge Repair',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          order.problemDescription!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: KoreColors.textLight,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: KoreButton(
            text: 'Cancel',
            onPressed: () => _showCancelConfirmation(context),
            isPrimary: false,
            isCancel: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: KoreButton(
            text: 'Accept',
            onPressed: () {
              Navigator.of(context).pop(); // Close the bottom sheet
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderInboxScreen(order: order),
                ),
              );
              onAccept?.call(); // Call the original callback if provided
            },
            isPrimary: true,
          ),
        ),
      ],
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CancelOrderBottomSheet(
        order: order,
        onConfirmCancel: () {
          Navigator.of(context).pop(); // Close the cancellation modal
          Navigator.of(context).pop(); // Close the order details modal
          onCancel?.call(); // Call the original cancel callback
        },
      ),
    );
  }
}
