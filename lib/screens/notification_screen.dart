import 'package:flutter/material.dart';
import 'notification_model.dart';
import 'dart:ui'; // Required for the blur effect

class NotificationScreen extends StatefulWidget {
  final List<NotificationItem> notifications;
  final VoidCallback onMarkAllRead;

  const NotificationScreen({
    super.key,
    required this.notifications,
    required this.onMarkAllRead,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5), // Matching your theme's Light Red/Rose
      extendBodyBehindAppBar: true, // Allows content to scroll under the blurred AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.8),
              elevation: 0,
              centerTitle: false,
              title: const Text(
                "Notifications",
                style: TextStyle(
                  color: Color(0xFF103931),
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  letterSpacing: -0.5,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton.icon(
                    onPressed: () {
                      widget.onMarkAllRead();
                      setState(() {});
                    },
                    icon: const Icon(Icons.done_all_rounded, size: 18, color: Colors.red),
                    label: const Text(
                      "Mark All",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: widget.notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.only(top: 110, bottom: 40),
              physics: const BouncingScrollPhysics(),
              itemCount: widget.notifications.length,
              itemBuilder: (context, index) {
                return _buildAnimatedNotificationItem(index, widget.notifications[index]);
              },
            ),
    );
  }

  // STAGGERED ANIMATION: Cards slide in from the right
  Widget _buildAnimatedNotificationItem(int index, NotificationItem item) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0, end: 1),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(50 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: _buildNotificationCard(item),
    );
  }

  Widget _buildNotificationCard(NotificationItem item) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: item.isRead ? Colors.white.withOpacity(0.7) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: item.isRead 
                ? Colors.transparent 
                : Colors.red.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
        border: Border.all(
          color: item.isRead ? Colors.transparent : Colors.red.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            setState(() {
              item.isRead = true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Section with Pulse Effect
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: item.isRead ? Colors.grey[100] : const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        item.isRead ? Icons.notifications_none_rounded : Icons.notifications_active_rounded,
                        color: item.isRead ? Colors.grey : Colors.red,
                      ),
                    ),
                    if (!item.isRead)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 15),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.message,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: item.isRead ? FontWeight.w500 : FontWeight.w800,
                          color: item.isRead ? Colors.black54 : const Color(0xFF103931),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            "Just now",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.red.withOpacity(0.05), blurRadius: 20)
              ],
            ),
            child: Icon(Icons.notifications_off_outlined, size: 60, color: Colors.grey[300]),
          ),
          const SizedBox(height: 20),
          const Text(
            "All caught up!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF103931)),
          ),
          const SizedBox(height: 8),
          Text(
            "No new notifications at the moment.",
            style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}