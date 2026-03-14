class NotificationItem {
  final String id;
  final String message;
  final DateTime time;
  bool isRead; // This tracks the individual dot

  NotificationItem({
    required this.id,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}