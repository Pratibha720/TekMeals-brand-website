import 'package:flutter/material.dart';
import 'dart:async';
import 'order_model.dart';

class MyOrderScreen extends StatefulWidget {
  final List<OrderModel> orders;

  const MyOrderScreen({super.key, required this.orders});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  late Timer _globalTimer;

  @override
  void initState() {
    super.initState();
    _globalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _globalTimer.cancel();
    super.dispose();
  }

  // --- LOGIC METHODS ---

  void _handleCancel(OrderModel order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: const Text("Cancel Order", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Are you sure you want to cancel this order? This action cannot be undone."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Stay")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              setState(() {
                widget.orders.remove(order);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order cancelled successfully"), backgroundColor: Colors.red),
              );
            },
            child: const Text("Yes, Cancel", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditModal(OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditOrderPopup(
        order: order,
        onSave: (newCustoms) {
          setState(() {
            order.customization = newCustoms;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Order updated successfully"), backgroundColor: Color(0xFF103931)),
          );
        },
      ),
    );
  }

  LinearGradient _getCategoryGradient(String category) {
    switch (category.toUpperCase()) {
      case "BREAKFAST": return const LinearGradient(colors: [Color(0xFFFF9800), Color(0xFFFFC107)]);
      case "LUNCH": return const LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)]);
      case "SNACKS": return const LinearGradient(colors: [Color(0xFF00BCD4), Color(0xFF2196F3)]);
      case "DINNER": return const LinearGradient(colors: [Color(0xFF673AB7), Color(0xFF9C27B0)]);
      default: return const LinearGradient(colors: [Color(0xFF103931), Color(0xFF2E7D32)]);
    }
  }

  String _getFoodImage(String mealName) {
    if (mealName.contains("Paneer")) return "assets/images/paneer.png";
    if (mealName.contains("Paratha")) return "assets/images/paratha.png";
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
              itemBuilder: (context, index) {
                return TweenAnimationBuilder<double>(
                  key: ValueKey(widget.orders[index].orderId),
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 400 + (index * 150)),
                  curve: Curves.easeOutQuint,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(offset: Offset(0, 50 * (1 - value)), child: child),
                  ),
                  child: _buildCatchyOrderCard(widget.orders[index]),
                );
              },
            ),
    );
  }

  Widget _buildCatchyOrderCard(OrderModel order) {
    final gradient = _getCategoryGradient(order.category);
    final themeColor = gradient.colors.first;
    
    // UPDATED: 24 Hour Logic (24 * 60 * 60 seconds)
    final difference = DateTime.now().difference(order.placedAt);
    final remainingSeconds = (24 * 60 * 60) - difference.inSeconds;
    final bool isLocked = remainingSeconds <= 0;

    String timerText = "";
    if (!isLocked) {
      final hours = (remainingSeconds ~/ 3600).toString().padLeft(2, '0');
      final minutes = ((remainingSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
      final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
      timerText = "$hours:$minutes:$seconds";
    }

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
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 120, height: 120,
                  decoration: BoxDecoration(color: themeColor.withOpacity(0.05), shape: BoxShape.circle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: themeColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundImage: AssetImage(_getFoodImage(order.mealName)),
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
                              color: themeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text("#${order.orderId}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: themeColor)),
                          ),
                          const SizedBox(height: 5),
                          Text(order.mealName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF2D3436))),
                          Text(order.customization, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _StatusDot(color: isLocked ? Colors.grey : Colors.orange),
                              const SizedBox(width: 8),
                              Text(
                                isLocked ? "ORDER LOCKED" : "EDITABLE FOR $timerText",
                                style: TextStyle(
                                  fontSize: 10, 
                                  fontWeight: FontWeight.w800, 
                                  color: isLocked ? Colors.grey : Colors.orange,
                                  letterSpacing: 0.5
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isLocked ? null : () => _showEditModal(order),
                    icon: Icon(Icons.tune_rounded, size: 18, color: isLocked ? Colors.grey : themeColor),
                    label: Text("Edit Meal", style: TextStyle(fontWeight: FontWeight.bold, color: isLocked ? Colors.grey : themeColor)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: isLocked ? Colors.grey.shade200 : themeColor.withOpacity(0.5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLocked ? null : () => _handleCancel(order),
                    icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Colors.white),
                    label: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLocked ? Colors.grey.shade300 : Colors.redAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          Text("No Active Orders", style: TextStyle(color: Colors.grey.shade600, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// --- ANIMATED STATUS DOT ---
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
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _controller, child: Container(width: 8, height: 8, decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle)));
  }
}

// --- EDIT MODAL ---
class _EditOrderPopup extends StatefulWidget {
  final OrderModel order;
  final Function(String) onSave;
  const _EditOrderPopup({required this.order, required this.onSave});
  @override
  State<_EditOrderPopup> createState() => _EditOrderPopupState();
}

class _EditOrderPopupState extends State<_EditOrderPopup> {
  late String rice;
  late String dal;
  int rotis = 2;

  @override
  void initState() {
    super.initState();
    rice = widget.order.customization.contains("Plain") ? "Plain Rice" : "Jeera Rice";
    dal = widget.order.customization.contains("Tadka") ? "Dal Tadka" : "Dal Fry";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 20),
          const Text("Modify Your Order", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          const Divider(height: 40),
          _buildChoiceRow("Rice Choice", ["Jeera Rice", "Plain Rice"], rice, (v) => setState(() => rice = v)),
          const SizedBox(height: 20),
          _buildChoiceRow("Dal Choice", ["Dal Fry", "Dal Tadka"], dal, (v) => setState(() => dal = v)),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Extra Rotis", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Row(
                children: [
                  _qtyBtn(Icons.remove, () => setState(() => rotis > 0 ? rotis-- : null)),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text("$rotis", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  _qtyBtn(Icons.add, () => setState(() => rotis++)),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity, height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF103931), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
              onPressed: () {
                widget.onSave("$rice + $dal + $rotis Roti");
                Navigator.pop(context);
              },
              child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceRow(String title, List<String> options, String current, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 10),
        Row(children: options.map((o) => Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ChoiceChip(
            label: Text(o), selected: current == o, 
            onSelected: (_) => onSelect(o),
            selectedColor: const Color(0xFF103931),
            labelStyle: TextStyle(color: current == o ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
          ),
        ))).toList()),
      ],
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback tap) => InkWell(
    onTap: tap, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle), child: Icon(icon, size: 20)),
  );
}