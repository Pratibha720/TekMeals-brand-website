import 'package:flutter/material.dart';

enum OrderStatus { placed, preparing, ready, received }

class OrderModel {
  final String orderId;
  final String mealName;
  final String customization;
  final String category;
  final String time;
  final String price;
  final OrderStatus status;

  OrderModel({
    required this.orderId,
    required this.mealName,
    required this.customization,
    required this.category,
    required this.time,
    required this.price,
    required this.status,
  });
}