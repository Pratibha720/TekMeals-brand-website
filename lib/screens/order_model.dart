enum OrderStatus { placed, preparing, outForDelivery, delivered }

class OrderModel {
  final String orderId;
  String mealName;        // Remove 'final'
  String customization;   // Remove 'final'
  final String category;
  final String time;
  String price;           // Remove 'final'
  final OrderStatus status;
  final DateTime placedAt;

  OrderModel({
    required this.orderId,
    required this.mealName,
    required this.customization,
    required this.category,
    required this.time,
    required this.price,
    required this.status,
  }) : placedAt = DateTime.now();
}