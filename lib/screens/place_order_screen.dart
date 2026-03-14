import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'order_model.dart';
import 'individual_meals_page.dart';
import 'combo_meals_page.dart';

class PlaceOrderScreen extends StatefulWidget {
  final VoidCallback onViewOrder;
  final Function(OrderModel) onOrderConfirmed;

  const PlaceOrderScreen({
    super.key,
    required this.onViewOrder,
    required this.onOrderConfirmed,
  });

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Timer _timer;
  Duration _timeLeft = const Duration(hours: 2, minutes: 45, seconds: 12);
  Color currentThemeColor = const Color(0xFF4CAF50);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _timeLeft.inSeconds > 0) {
        setState(() => _timeLeft -= const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}h ${twoDigits(duration.inMinutes.remainder(60))}m ${twoDigits(duration.inSeconds.remainder(60))}s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.fromLTRB(25, 60, 25, 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  currentThemeColor,
                  currentThemeColor.withAlpha(200), // Safer than manual RGB math
                ],
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: currentThemeColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "BOOKING FOR NEXT DAY",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 9, letterSpacing: 1.2),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Wednesday, Mar 4",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5),
                    ),
                  ],
                ),
                _buildAnimatedTimer(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(25, 25, 25, 10),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(colors: [currentThemeColor, currentThemeColor.withOpacity(0.8)]),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade400,
              labelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              padding: const EdgeInsets.all(6),
              tabs: const [Tab(text: "Individual"), Tab(text: "Combos")],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                IndividualMealsPage(
                  onOrderConfirmed: widget.onOrderConfirmed,
                  onColorChange: (newColor) => setState(() => currentThemeColor = newColor),
                ),
                ComboMealsPage(
                  onOrderConfirmed: widget.onOrderConfirmed,
                  onColorChange: (newColor) => setState(() => currentThemeColor = newColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTimer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_filled, size: 12, color: currentThemeColor),
              const SizedBox(width: 4),
              const Text("CLOSING IN", style: TextStyle(color: Colors.grey, fontSize: 8, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            _formatDuration(_timeLeft),
            style: TextStyle(color: currentThemeColor, fontWeight: FontWeight.w900, fontSize: 14, fontFeatures: const [FontFeature.tabularFigures()]),
          ),
        ],
      ),
    );
  }
}