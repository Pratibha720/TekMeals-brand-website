import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
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
  
  // Logic Variables
  Duration _timeLeft = Duration.zero;
  String _bookingLabel = "LOADING...";
  String _displayDate = "";
  bool _isWindowOpen = true;
  
  // THE LOCKING MECHANISM
  // This tracks if the user has already placed their ONE allowed order for the current active date.
  bool _hasOrderedInCurrentWindow = false;
  String _currentActiveDateString = ""; 

  Color currentThemeColor = const Color(0xFF4CAF50);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _calculateTimeLogic(); 
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _calculateTimeLogic();
      }
    });
  }

  void _calculateTimeLogic() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    DateTime cutoffToday = today.add(const Duration(hours: 16)); // 4 PM
    DateTime cutoffNextDay = today.add(const Duration(hours: 23)); // 11 PM

    setState(() {
      String newDateString = "";
      
      if (now.isBefore(cutoffToday)) {
        // WINDOW 1: Booking for TODAY (Locking at 4 PM)
        _isWindowOpen = true;
        _bookingLabel = "BOOKING FOR TODAY";
        newDateString = DateFormat('yyyy-MM-dd').format(now); // Unique ID for today
        _displayDate = DateFormat('EEEE, MMM d').format(now);
        _timeLeft = cutoffToday.difference(now);
      } 
      else if (now.isAfter(cutoffToday) && now.isBefore(cutoffNextDay)) {
        // WINDOW 2: Booking for NEXT DAY (Starts 4 PM, Ends 11 PM)
        _isWindowOpen = true;
        _bookingLabel = "BOOKING FOR NEXT DAY";
        newDateString = DateFormat('yyyy-MM-dd').format(now.add(const Duration(days: 1))); // Unique ID for tomorrow
        _displayDate = DateFormat('EEEE, MMM d').format(now.add(const Duration(days: 1)));
        _timeLeft = cutoffNextDay.difference(now);
      } 
      else {
        // WINDOW 3: CLOSED (11 PM to Midnight)
        _isWindowOpen = false;
        _bookingLabel = "BOOKINGS CLOSED";
        _displayDate = "Reopens at Midnight";
        _timeLeft = Duration.zero;
        newDateString = "CLOSED";
      }

      // If the date we are booking for changes (e.g., it was "Today" and now it's "Tomorrow"),
      // we reset the lock so the user can place their one order for the new day.
      if (_currentActiveDateString != "" && _currentActiveDateString != newDateString) {
        _hasOrderedInCurrentWindow = false;
      }
      _currentActiveDateString = newDateString;
    });
  }

  // When ANY meal is confirmed (Breakfast, Lunch, or Snack), this locks the WHOLE screen.
  void _interceptOrder(OrderModel order) {
    setState(() {
      _hasOrderedInCurrentWindow = true; 
    });
    widget.onOrderConfirmed(order);
    
    // Optional: Show a snackbar explaining the lock
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order Placed! Booking is now locked for this date.")),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration == Duration.zero) return "00h 00m 00s";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}h ${twoDigits(duration.inMinutes.remainder(60))}m ${twoDigits(duration.inSeconds.remainder(60))}s";
  }

  @override
  Widget build(BuildContext context) {
    // UI locks if:
    // 1. Window is past 11 PM (_isWindowOpen == false)
    // 2. User has already placed their one order for this target date.
    bool isEffectivelyLocked = !_isWindowOpen || _hasOrderedInCurrentWindow;

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
                  isEffectivelyLocked ? Colors.grey.shade700 : currentThemeColor,
                  isEffectivelyLocked ? Colors.grey.shade800 : currentThemeColor.withAlpha(200),
                ],
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
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
                      child: Text(
                        _hasOrderedInCurrentWindow ? "ORDER COMPLETED" : _bookingLabel,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 9, letterSpacing: 1.2),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _displayDate,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5),
                    ),
                  ],
                ),
                _buildAnimatedTimer(isEffectivelyLocked),
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
                gradient: LinearGradient(colors: [
                  !isEffectivelyLocked ? currentThemeColor : Colors.grey, 
                  !isEffectivelyLocked ? currentThemeColor.withOpacity(0.8) : Colors.grey.shade400
                ]),
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
            child: AbsorbPointer(
              absorbing: isEffectivelyLocked, 
              child: Opacity(
                opacity: isEffectivelyLocked ? 0.5 : 1.0,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    IndividualMealsPage(
                      onOrderConfirmed: _interceptOrder,
                      onColorChange: (newColor) => setState(() => currentThemeColor = newColor),
                    ),
                    ComboMealsPage(
                      onOrderConfirmed: _interceptOrder,
                      onColorChange: (newColor) => setState(() => currentThemeColor = newColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTimer(bool isLocked) {
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
              Icon(
                !isLocked ? Icons.access_time_filled : Icons.lock_clock, 
                size: 12, 
                color: !isLocked ? currentThemeColor : Colors.grey
              ),
              const SizedBox(width: 4),
              Text(
                !isLocked ? "CLOSING IN" : "STATUS", 
                style: const TextStyle(color: Colors.grey, fontSize: 8, fontWeight: FontWeight.w900)
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            _hasOrderedInCurrentWindow 
                ? "LOCKED" 
                : (_isWindowOpen ? _formatDuration(_timeLeft) : "CLOSED"),
            style: TextStyle(
              color: !isLocked ? currentThemeColor : Colors.grey, 
              fontWeight: FontWeight.w900, 
              fontSize: 14, 
              fontFeatures: const [FontFeature.tabularFigures()]
            ),
          ),
        ],
      ),
    );
  }
}