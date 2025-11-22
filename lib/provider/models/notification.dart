class NotificationItem {
  final String id;
  final String title;
  final String timestamp;
  final bool isRead;
  final String content;

  NotificationItem({
    required this.id,
    required this.title,
    required this.timestamp,
    required this.isRead,
    required this.content,
  });

  // Factory constructor to create from JSON
  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      timestamp: json['timestamp'] ?? '',
      isRead: json['isRead'] ?? false,
      content: json['content'] ?? '',
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'timestamp': timestamp,
      'isRead': isRead,
      'content': content,
    };
  }

  // Method to mark as read
  NotificationItem markAsRead() {
    return NotificationItem(
      id: id,
      title: title,
      timestamp: timestamp,
      isRead: true,
      content: content,
    );
  }
}
