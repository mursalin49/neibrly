import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../viewmodels/orders_viewmodel.dart';
import '../../widgets/orders/order_card.dart';
import '../../widgets/orders/filter_tabs.dart';
import 'package:naibrly/widgets/payment_confirmation_bottom_sheet.dart';
import '../../widgets/colors.dart';
import 'package:naibrly/provider/widgets/naibrly_request_bottom_sheet.dart';
import '../../screens/order_inbox_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _currentBottomNavIndex = 1; // Orders tab is selected
  bool isLocationEnabled = false;
  int selectedMiles = 3;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrdersViewModel(),
      child: Scaffold(
        backgroundColor: KoreColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Your Orders',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                onPressed: () {
                  _showNaibrlyRequestBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7A60),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Naibrly Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Consumer<OrdersViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                // Filter tabs
                FilterTabs(
                  currentFilter: viewModel.currentFilter,
                  onFilterChanged: (filter) => viewModel.setFilter(filter),
                  openCount: viewModel.openOrdersCount,
                  closedCount: viewModel.closedOrdersCount,
                ),
                
                // Orders list
                Expanded(
                  child: viewModel.orders.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: viewModel.orders.length,
                          itemBuilder: (context, index) {
                            final order = viewModel.orders[index];
                            return OrderCard(
                              order: order,
                              onTap: () => _showOrderDetails(context, order, viewModel),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: KoreColors.textLight.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'No orders found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: KoreColors.textLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'You don\'t have any ${_getCurrentFilterText()} orders yet',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: KoreColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentFilterText() {
    return context.read<OrdersViewModel>().currentFilter == OrderFilter.open 
        ? 'open' 
        : 'closed';
  }

  void _showOrderDetails(BuildContext context, order, OrdersViewModel viewModel) {
    // Only show bottom sheet for pending orders
    if (order.status == OrderStatus.pending) {
      showOrderDetailsBottomSheet(
        context,
        orderData: {
          'id': order.id,
          'status': order.status.toString().split('.').last,
          'customer': order.clientName,
          'service': order.serviceName,
          'amount': order.averagePrice.toString(),
          'date': order.date.toString(),
          'notes': order.problemDescription,
        },
      );
    } else if (order.status == OrderStatus.accepted || order.status == OrderStatus.cancelled || order.status == OrderStatus.completed) {
      // For accepted, cancelled, and completed orders, navigate to OrderInboxScreen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderInboxScreen(order: order),
        ),
      );
    } else {
      // For other orders, show a simple snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order details for ${order.serviceName} (${order.statusText})'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showNaibrlyRequestBottomSheet(BuildContext context) {
    showNaibrlyRequestBottomSheet(
      context,
      initialLocationEnabled: isLocationEnabled,
      initialSelectedMiles: selectedMiles,
      onLocationChanged: (value) => setState(() => isLocationEnabled = value),
      onMilesChanged: (value) => setState(() => selectedMiles = value),
      onSend: () {},
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        // Already on orders screen
        break;
      case 2:
        // TODO: Navigate to notifications
        break;
      case 3:
        // TODO: Navigate to profile
        break;
    }
  }

  Widget _buildRadioOption(String miles, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0E7A60) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF0E7A60) : const Color(0xFFE5E5E5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      size: 12,
                      color: Color(0xFF0E7A60),
                    ),
                  ),
                )
              else
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
                    shape: BoxShape.circle,
                  ),
                ),
              const SizedBox(width: 6),
              Text(
                "$miles miles",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF1C1C1C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NaibrlyRequestBottomSheet extends StatefulWidget {
  final bool isLocationEnabled;
  final int selectedMiles;
  final ValueChanged<bool> onLocationChanged;
  final ValueChanged<int> onMilesChanged;

  const _NaibrlyRequestBottomSheet({
    required this.isLocationEnabled,
    required this.selectedMiles,
    required this.onLocationChanged,
    required this.onMilesChanged,
  });

  @override
  State<_NaibrlyRequestBottomSheet> createState() => _NaibrlyRequestBottomSheetState();
}

class _NaibrlyRequestBottomSheetState extends State<_NaibrlyRequestBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/roundCross.png"),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  Image.asset(
                    "assets/images/tickMark.png",
                    height: 120,
                    width: 159,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Naibrly Request",
                    style: TextStyle(
                      color: Color(0xFF1C1C1C),
                      fontSize: 18,
                      //textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "On your current location",
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 15,
                      //textAlign: TextAlign.center,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Location Toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1C1C1C),
                              ),
                            ),
                            Switch(
                              value: widget.isLocationEnabled,
                              onChanged: (value) {
                                widget.onLocationChanged(value);
                              },
                              activeColor: const Color(0xFF0E7A60),
                            ),
                          ],
                        ),
                        if (!widget.isLocationEnabled) ...[
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFF34F4F), width: 1),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Please on your location",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFF34F4F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Send to nearby user within
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Send to nearby user within*",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildRadioOption("3", widget.selectedMiles == 3, () {
                              widget.onMilesChanged(3);
                            }),
                            const SizedBox(width: 12),
                            _buildRadioOption("10", widget.selectedMiles == 10, () {
                              widget.onMilesChanged(10);
                            }),
                            const SizedBox(width: 12),
                            _buildRadioOption("15", widget.selectedMiles == 15, () {
                              widget.onMilesChanged(15);
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Send Ping Button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Add send ping functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E7A60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Send Ping',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                    SizedBox(height: 20),
                ],
                ),
              ),
            ),
          ],
        );
  }

  Widget _buildRadioOption(String miles, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0E7A60) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF0E7A60) : const Color(0xFFE5E5E5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      size: 12,
                      color: Color(0xFF0E7A60),
                    ),
                  ),
                )
              else
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
                    shape: BoxShape.circle,
                  ),
                ),
              const SizedBox(width: 6),
              Text(
                "$miles miles",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF1C1C1C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NaibrlyIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0E7A60)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw the git merge-like icon
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw the two 'U' shapes
    final path1 = Path();
    path1.moveTo(centerX - 12, centerY - 8);
    path1.quadraticBezierTo(centerX - 12, centerY, centerX - 12, centerY + 10);
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(centerX + 12, centerY - 8);
    path2.quadraticBezierTo(centerX + 12, centerY, centerX + 12, centerY + 10);
    canvas.drawPath(path2, paint);

    // Draw the dots at the base
    canvas.drawCircle(Offset(centerX - 12, centerY + 14), 2, paint);
    canvas.drawCircle(Offset(centerX + 12, centerY + 14), 2, paint);

    // Draw arrows pointing towards each other at the top
    final arrowPaint = Paint()
      ..color = const Color(0xFF0E7A60)
      ..style = PaintingStyle.fill;

    // Left arrow
    final leftArrowPath = Path();
    leftArrowPath.moveTo(centerX - 6, centerY - 8);
    leftArrowPath.lineTo(centerX - 10, centerY - 8);
    leftArrowPath.lineTo(centerX - 10, centerY - 6);
    leftArrowPath.close();
    canvas.drawPath(leftArrowPath, arrowPaint);

    // Right arrow
    final rightArrowPath = Path();
    rightArrowPath.moveTo(centerX + 6, centerY - 8);
    rightArrowPath.lineTo(centerX + 10, centerY - 8);
    rightArrowPath.lineTo(centerX + 10, centerY - 6);
    rightArrowPath.close();
    canvas.drawPath(rightArrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
