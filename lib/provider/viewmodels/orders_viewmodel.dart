import 'package:flutter/foundation.dart';
import '../models/order.dart';

class OrdersViewModel extends ChangeNotifier {
  List<Order> _allOrders = Order.getAllDemoOrders();
  OrderFilter _currentFilter = OrderFilter.open;
  List<Order> _filteredOrders = [];

  // Getters
  List<Order> get orders => _filteredOrders;
  OrderFilter get currentFilter => _currentFilter;
  int get openOrdersCount => _allOrders.where((order) => 
    order.status == OrderStatus.pending || order.status == OrderStatus.accepted).length;
  int get closedOrdersCount => _allOrders.where((order) => 
    order.status == OrderStatus.completed || order.status == OrderStatus.cancelled).length;

  OrdersViewModel() {
    _applyFilter();
  }

  void setFilter(OrderFilter filter) {
    _currentFilter = filter;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    switch (_currentFilter) {
      case OrderFilter.open:
        _filteredOrders = _allOrders.where((order) => 
          order.status == OrderStatus.pending || order.status == OrderStatus.accepted).toList();
        break;
      case OrderFilter.closed:
        _filteredOrders = _allOrders.where((order) => 
          order.status == OrderStatus.completed || order.status == OrderStatus.cancelled).toList();
        break;
    }
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final orderIndex = _allOrders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final order = _allOrders[orderIndex];
      _allOrders[orderIndex] = Order(
        id: order.id,
        serviceName: order.serviceName,
        averagePrice: order.averagePrice,
        date: order.date,
        time: order.time,
        imagePath: order.imagePath,
        status: newStatus,
        problemDescription: order.problemDescription,
        clientName: order.clientName,
        clientImage: order.clientImage,
        clientRating: order.clientRating,
        clientReviewCount: order.clientReviewCount,
        address: order.address,
        isTeamService: order.isTeamService,
        teamMembers: order.teamMembers,
        bundleType: order.bundleType,
      );
      _applyFilter();
      notifyListeners();
    }
  }
}

enum OrderFilter { open, closed }
