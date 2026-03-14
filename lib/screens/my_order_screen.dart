import 'package:flutter/material.dart';
import 'order_model.dart';

class MyOrderScreen extends StatefulWidget {
  final List<OrderModel> orders;

  const MyOrderScreen({super.key, required this.orders});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  // Vibrant, catchy gradient palette based on meal category
  LinearGradient _getCategoryGradient(String category) {
    switch (category.toUpperCase()) {
      case "BREAKFAST":
        return const LinearGradient(colors: [Color(0xFFFF9800), Color(0xFFFFC107)]);
      case "LUNCH":
        return const LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)]);
      case "SNACKS":
        return const LinearGradient(colors: [Color(0xFF00BCD4), Color(0xFF2196F3)]);
      case "DINNER":
        return const LinearGradient(colors: [Color(0xFF673AB7), Color(0xFF9C27B0)]);
      default:
        return const LinearGradient(colors: [Color(0xFF103931), Color(0xFF2E7D32)]);
    }
  }

  String _getFoodImage(String mealName) {
    if (mealName.contains("Paneer")) return "assets/images/paneer.png";
    if (mealName.contains("Paratha")) return "assets/images/paratha.png";
    if (mealName.contains("Chicken")) return "assets/images/chicken.png";
    if (mealName.contains("Samosa")) return "assets/images/samosa.png";
    if (mealName.contains("Pizza")) return "assets/images/pizza.png";
    return "assets/images/ind_lu.png";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F3F7), 
      body: widget.orders.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: widget.orders.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                // ADDED: Staggered entrance animation
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 400 + (index * 150)),
                  curve: Curves.easeOutQuint,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: _buildAnimatedOrderCard(widget.orders[index]),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) => Transform.scale(scale: value, child: child),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)
              ]),
              child: Icon(Icons.shopping_bag_outlined, size: 60, color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(height: 20),
          Text("No orders placed yet", 
            style: TextStyle(color: Colors.grey.shade600, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Wrapper for "Hover/Touch" effect
  Widget _buildAnimatedOrderCard(OrderModel order) {
    return _HoverScaleWrapper(
      child: _buildCatchyOrderCard(order),
    );
  }

  Widget _buildCatchyOrderCard(OrderModel order) {
    final gradient = _getCategoryGradient(order.category);
    final themeColor = gradient.colors.first;
    bool isReceived = order.status == OrderStatus.received;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.12),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: gradient.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Hero(
                    tag: order.orderId,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: themeColor.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: CircleAvatar(
                            radius: 42,
                            backgroundImage: AssetImage(_getFoodImage(order.mealName)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: gradient.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "#${order.orderId.toUpperCase()}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: themeColor,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          order.mealName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2D3436),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey.shade500),
                            const SizedBox(width: 4),
                            Text(
                              order.time,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isReceived ? const Color(0xFFFFF0F3) : themeColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: isReceived ? Colors.pink.withOpacity(0.2) : themeColor.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Pulsing dot animation for "Preparing"
                              _StatusDot(color: isReceived ? Colors.pink : themeColor),
                              const SizedBox(width: 8),
                              Text(
                                isReceived ? "OUT FOR DELIVERY" : "PREPARING",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: isReceived ? Colors.pink : themeColor,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
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
}

// HELPER: Handles the scale-down effect when tapping (Mobile "Hover")
class _HoverScaleWrapper extends StatefulWidget {
  final Widget child;
  const _HoverScaleWrapper({required this.child});

  @override
  State<_HoverScaleWrapper> createState() => _HoverScaleWrapperState();
}

class _HoverScaleWrapperState extends State<_HoverScaleWrapper> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.97),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}

// HELPER: A small pulsing dot for the status indicator
class _StatusDot extends StatefulWidget {
  final Color color;
  const _StatusDot({required this.color});

  @override
  State<_StatusDot> createState() => _StatusDotState();
}

class _StatusDotState extends State<_StatusDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.4, end: 1.0).animate(_controller),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}