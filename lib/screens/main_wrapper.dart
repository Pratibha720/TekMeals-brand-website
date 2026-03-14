import 'package:flutter/material.dart';
// Ensure these paths match your actual folder structure
import 'place_order_screen.dart'; 
import 'my_order_screen.dart';
import 'order_history_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart'; 
import 'order_model.dart';
import 'notification_model.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  List<OrderModel> activeOrders = [];

  List<NotificationItem> notifications = [
    NotificationItem(
      id: "1",
      message: "Today's lunch menu: Paneer Butter Masala & Dal Tadka! 🍛",
      time: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    NotificationItem(
      id: "2",
      message: "Flash Sale: Get 10% off on all Snacks today between 4-5 PM.",
      time: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  bool get _hasUnread => notifications.any((n) => !n.isRead);

  List<OrderModel> completedOrders = [
    OrderModel(orderId: "#231", mealName: "Special Combo", customization: "Jeera Rice + Dal Fry", category: "LUNCH", time: "12:30 PM", price: "150", status: OrderStatus.placed),
    OrderModel(orderId: "#1196", mealName: "Fried Rice", customization: "Standard Portion", category: "SNACKS", time: "04:00 PM", price: "120", status: OrderStatus.placed),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _placeNewOrder(OrderModel newOrder) {
    setState(() {
      activeOrders.add(newOrder);
      _selectedIndex = 1; // Auto-switch to "My Order" tab
    });
    _addNotification("New Order: ${newOrder.mealName} placed successfully! 🍱");
  }

  void _addNotification(String message) {
    setState(() {
      notifications.insert(0, NotificationItem(id: DateTime.now().toString(), message: message, time: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // These are the pages corresponding to the BottomNavBar items
    final List<Widget> _pages = [
      PlaceOrderScreen(
        onViewOrder: () => _onItemTapped(1), 
        onOrderConfirmed: _placeNewOrder
      ),
      MyOrderScreen(orders: activeOrders),
      OrderHistoryScreen(historyOrders: completedOrders),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.restaurant, color: Colors.red),
            SizedBox(width: 8),
            Text("TekMeals", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: _hasUnread,
              child: const Icon(Icons.notifications_none, color: Colors.black, size: 28),
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(
                    notifications: notifications,
                    onMarkAllRead: () {
                      setState(() { for (var n in notifications) { n.isRead = true; } });
                    },
                  ),
                ),
              );
              setState(() {});
            },
          ),
          GestureDetector(
            onTap: () => _onItemTapped(3),
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 18,
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack( // Using IndexedStack preserves page state when switching tabs
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Place Order"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "My Order"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}