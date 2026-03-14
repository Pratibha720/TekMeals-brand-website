import 'package:flutter/material.dart';
import 'order_model.dart';
import 'dart:ui';

class OrderHistoryScreen extends StatelessWidget {
  final List<OrderModel> historyOrders;

  const OrderHistoryScreen({super.key, required this.historyOrders});

  @override
  Widget build(BuildContext context) {
    // FRONTEND DUMMY DATA
    final List<OrderModel> dummyHistory = [
      OrderModel(
        orderId: "#231",
        mealName: "Special Combo",
        customization: "Jeera Rice + Dal Fry + Paneer",
        category: "LUNCH",
        time: "12:30 PM",
        price: "150",
        status: OrderStatus.placed,
      ),
      OrderModel(
        orderId: "#1196",
        mealName: "Fried Rice",
        customization: "Standard Portion",
        category: "SNACKS",
        time: "04:00 PM",
        price: "120",
        status: OrderStatus.placed,
      ),
      OrderModel(
        orderId: "#4522",
        mealName: "English Breakfast",
        customization: "Sunny Side Up + Extra Beans",
        category: "BREAKFAST",
        time: "08:15 AM",
        price: "180",
        status: OrderStatus.placed,
      ),
    ];

    return Scaffold(
      // Light Red / Rose Background
      backgroundColor: const Color(0xFFFFF5F5), 
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- STYLISH DYNAMIC HEADER ---
          SliverAppBar(
            expandedHeight: 140.0,
            floating: false,
            pinned: true,
            elevation: 0,
            stretch: true,
            backgroundColor: const Color(0xFFE53935),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
              title: const Text(
                "Order History",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFB71C1C), Color(0xFFE53935)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -20, right: -20,
                    child: CircleAvatar(
                      radius: 60, 
                      backgroundColor: Colors.white.withOpacity(0.1)
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- ANIMATED LIST ---
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildEnhancedAnimatedCard(index, dummyHistory[index]);
                },
                childCount: dummyHistory.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ADVANCED ANIMATION: Scale + Fade + Slide
  Widget _buildEnhancedAnimatedCard(int index, OrderModel order) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 200)),
      curve: Curves.elasticOut, 
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: _buildModernCardLayout(order),
    );
  }

  Widget _buildModernCardLayout(OrderModel order) {
    final Map<String, dynamic> theme = _getCategoryTheme(order.category);
    final Color primaryColor = theme['primary'] as Color;
    final Color bgColor = theme['accent'] as Color;
    final IconData catIcon = theme['icon'] as IconData;

    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Reduced margin since floating button is gone
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            // Top Gradient Banner
            Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withOpacity(0.15), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.orderId,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                  _buildStatusChip("COMPLETED"),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Vibrant Category Icon Box
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(catIcon, color: primaryColor, size: 28),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.mealName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF103931),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              order.customization,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade500, 
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  
                  // Glass-style Info Bar
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoItem(Icons.calendar_month_rounded, "12 MAR 2026"),
                        Container(height: 20, width: 1.5, color: Colors.grey.shade200),
                        _buildInfoItem(Icons.restaurant_menu_rounded, order.category),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified_rounded, color: Colors.green, size: 14),
          const SizedBox(width: 6),
          Text(
            label, 
            style: const TextStyle(
              color: Colors.green, 
              fontSize: 10, 
              fontWeight: FontWeight.w900
            )
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF103931).withOpacity(0.6)),
        const SizedBox(width: 8),
        Text(
          label, 
          style: const TextStyle(
            fontSize: 12, 
            fontWeight: FontWeight.w800, 
            color: Colors.black87
          )
        ),
      ],
    );
  }

  // THEME HELPER
  Map<String, dynamic> _getCategoryTheme(String category) {
    switch (category.toUpperCase()) {
      case "LUNCH":
        return {
          'primary': Colors.orange.shade800, 
          'accent': const Color(0xFFFFF3E0), 
          'icon': Icons.lunch_dining_rounded
        };
      case "SNACKS":
        return {
          'primary': Colors.pink.shade700, 
          'accent': const Color(0xFFFCE4EC), 
          'icon': Icons.bakery_dining_rounded
        };
      case "BREAKFAST":
        return {
          'primary': Colors.blue.shade700, 
          'accent': const Color(0xFFE3F2FD), 
          'icon': Icons.wb_twilight_rounded
        };
      case "DINNER":
        return {
          'primary': Colors.indigo.shade700, 
          'accent': const Color(0xFFE8EAF6), 
          'icon': Icons.dark_mode_rounded
        };
      default:
        return {
          'primary': Colors.red.shade700, 
          'accent': const Color(0xFFFFEBEE), 
          'icon': Icons.restaurant_rounded
        };
    }
  }
}