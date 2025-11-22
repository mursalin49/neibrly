import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';

class ServiceRequestCard extends StatelessWidget {
  final String serviceName;
  final double pricePerHour;
  final String clientName;
  final String clientImage;
  final double clientRating;
  final int clientReviewCount;
  final String address;
  final String date;
  final String time;
  final String? problemNote;
  final VoidCallback? onAccept;
  final VoidCallback? onCancel;

  const ServiceRequestCard({
    super.key,
    required this.serviceName,
    required this.pricePerHour,
    required this.clientName,
    required this.clientImage,
    required this.clientRating,
    required this.clientReviewCount,
    required this.address,
    required this.date,
    required this.time,
    this.problemNote,
    this.onAccept,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
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
              AppText(
                serviceName,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.Black,
              ),
              AppText(
                " : ",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.Black,
              ),
              AppText(
                '\$${pricePerHour.toInt()}/hr',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Client info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(clientImage),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    clientName,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.Black,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.black, size: 14),
                      const SizedBox(width: 4),
                      AppText(
                        '$clientRating ($clientReviewCount reviews)',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.Black,
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
              AppText(
                'Address: ',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.Black,
              ),
              Expanded(
                child: AppText(
                  address,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.DarkGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Date and time
          Row(
            children: [
              AppText(
                'Date: $date',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.DarkGray,
              ),
              const SizedBox(width: 16),
              AppText(
                'Time: $time',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.DarkGray,
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Problem note
          if (problemNote != null) ...[
            AppText(
              'Problem Note',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.Black,
            ),
            const SizedBox(height: 4),
            AppText(
              problemNote!,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.DarkGray,
            ),
            const SizedBox(height: 16),
          ],
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: IosTapEffect(
                  onTap: onCancel ?? () {},
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEEEEE),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFF34F4F), width: 1),
                    ),
                    child: Center(
                      child: AppText(
                        'Cancel',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF34F4F),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: IosTapEffect(
                  onTap: onAccept ?? () {},
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: AppText(
                        'Accept',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
