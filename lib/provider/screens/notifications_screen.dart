import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int? _expandedIndex;

  // Sample notification data
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'New Request from 19706',
      timestamp: '11:30 AM',
      isRead: false,
      content: 'Lorem ipsum dolor sit amet consectetur. Dui at netus aliquam felis. Et maecenas nunc pulvinar proin ut. Sed sit quis diam euismod sed commodo at bibendum laoreet.',
    ),
    NotificationItem(
      id: '2',
      title: 'New Request from 19706',
      timestamp: '11:30 AM',
      isRead: false,
      content: 'Lorem ipsum dolor sit amet consectetur. Dui at netus aliquam felis. Et maecenas nunc pulvinar proin ut. Sed sit quis diam euismod sed commodo at bibendum laoreet.',
    ),
    NotificationItem(
      id: '3',
      title: 'New Request from 19706',
      timestamp: '11:30 AM',
      isRead: false,
      content: 'Lorem ipsum dolor sit amet consectetur. Dui at netus aliquam felis. Et maecenas nunc pulvinar proin ut. Sed sit quis diam euismod sed commodo at bibendum laoreet.',
    ),
    NotificationItem(
      id: '4',
      title: 'New Request from 19706',
      timestamp: '11:30 AM',
      isRead: true,
      content: 'Lorem ipsum dolor sit amet consectetur. Dui at netus aliquam felis. Et maecenas nunc pulvinar proin ut. Sed sit quis diam euismod sed commodo at bibendum laoreet.',
    ),
    NotificationItem(
      id: '5',
      title: 'New Request from 19706',
      timestamp: 'Yesterday',
      isRead: true,
      content: 'Lorem ipsum dolor sit amet consectetur. Dui at netus aliquam felis. Et maecenas nunc pulvinar proin ut. Sed sit quis diam euismod sed commodo at bibendum laoreet.',
    ),
    NotificationItem(
      id: '6',
      title: 'New Request from 19706',
      timestamp: '15 Jan, 2016',
      isRead: true,
      content: 'Lorem ipsum dolor sit amet consectetur. Dui at netus aliquam felis. Et maecenas nunc pulvinar proin ut. Sed sit quis diam euismod sed commodo at bibendum laoreet.',
    ),
    NotificationItem(
      id: '7',
      title: 'New Request from 19706',
      timestamp: '11:30 AM',
      isRead: true,
      content: 'Lorem ipsum dolor sit amet consectetur. Dui at netus aliquam felis. Et maecenas nunc pulvinar proin ut. Sed sit quis diam euismod sed commodo at bibendum laoreet.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/notification.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            const Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          final isExpanded = _expandedIndex == index;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_expandedIndex == index) {
                    _expandedIndex = null;
                  } else {
                    _expandedIndex = index;
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isExpanded ? Colors.grey[100] : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isExpanded 
                    ? Border.all(color: Colors.grey[300]!, width: 1)
                    : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: notification.isRead 
                                ? Colors.grey[400] 
                                : Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              notification.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          notification.timestamp,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      if (isExpanded) ...[
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            notification.content,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}

