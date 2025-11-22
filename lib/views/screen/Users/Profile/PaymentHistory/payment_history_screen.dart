import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icon.dart';
import '../../../../base/AppText/appText.dart';
import '../../../../base/Ios_effect/iosTapEffect.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> paymentHistory = [
    {
      'id': '1',
      'service': 'Appliance Repair',
      'provider': 'Jacob Brothers',
      'amount': 120.00,
      'date': '2024-01-15',
      'status': 'Completed',
      'paymentMethod': 'Credit Card',
      'transactionId': 'TXN-001234567',
    },
    {
      'id': '2',
      'service': 'House Cleaning',
      'provider': 'CleanPro Services',
      'amount': 85.00,
      'date': '2024-01-10',
      'status': 'Completed',
      'paymentMethod': 'PayPal',
      'transactionId': 'TXN-001234568',
    },
    {
      'id': '3',
      'service': 'HVAC Maintenance',
      'provider': 'Climate Control Experts',
      'amount': 200.00,
      'date': '2024-01-05',
      'status': 'Pending',
      'paymentMethod': 'Credit Card',
      'transactionId': 'TXN-001234569',
    },
    {
      'id': '4',
      'service': 'Window Washing',
      'provider': 'Sparkle Clean Co.',
      'amount': 65.00,
      'date': '2023-12-28',
      'status': 'Completed',
      'paymentMethod': 'Debit Card',
      'transactionId': 'TXN-001234570',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.White,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.Black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const AppText(
          "Payment History",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.Black,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const AppText(
                  "Filter:",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.Black,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'Completed', 'Pending', 'Failed'].map((filter) {
                        final isSelected = selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IosTapEffect(
                            onTap: () {
                              setState(() {
                                selectedFilter = filter;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : AppColors.LightGray,
                                  width: 1,
                                ),
                              ),
                              child: AppText(
                                filter,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.white : AppColors.DarkGray,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(color: Color(0xFFEEEEEE)),
          
          // Payment History List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: paymentHistory.length,
              itemBuilder: (context, index) {
                final payment = paymentHistory[index];
                final isCompleted = payment['status'] == 'Completed';
                final isPending = payment['status'] == 'Pending';
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.LightGray),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  payment['service'],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.Black,
                                ),
                                const SizedBox(height: 4),
                                AppText(
                                  payment['provider'],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.DarkGray,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppText(
                                '\$${payment['amount'].toStringAsFixed(2)}',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.Black,
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isCompleted 
                                    ? Colors.green.withOpacity(0.1)
                                    : isPending 
                                      ? Colors.orange.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: AppText(
                                  payment['status'],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isCompleted 
                                    ? Colors.green
                                    : isPending 
                                      ? Colors.orange
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          AppText(
                            'Date: ',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.DarkGray,
                          ),
                          AppText(
                            payment['date'],
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.DarkGray,
                          ),
                          const Spacer(),
                          AppText(
                            'Method: ',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.DarkGray,
                          ),
                          AppText(
                            payment['paymentMethod'],
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.DarkGray,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      AppText(
                        'Transaction ID: ${payment['transactionId']}',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.DarkGray,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
