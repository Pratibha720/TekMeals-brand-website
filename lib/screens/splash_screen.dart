import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _contentController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Setup Content Animation (Logo and Text)
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );

    // UPDATED: Using easeOutBack for the bounce effect
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutBack),
    );

    // 2. Setup Progress Animation (0% to 75%)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.75).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    // Start animations
    _contentController.forward();
    _progressController.forward();

    // Navigate to Login after 3.5 seconds
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image with Opacity
          Opacity(
            opacity: 0.3,
            child: Image.asset('assets/images/splash_bg.png', fit: BoxFit.cover),
          ),

          // 2. Center Content (Logo and Text)
          AnimatedBuilder(
            animation: _contentController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 100),
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                      TextSpan(text: 'Tek'),
                      TextSpan(text: 'Meals', style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                ),
                const Text("Freshness at your doorstep", style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),

          // 3. Bottom Loading Section
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("SETTING THE TABLE", 
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(
                          "${(_progressAnimation.value * 100).toInt()}%",
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: _progressAnimation.value,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                      minHeight: 6,
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified_user, size: 14, color: Colors.orange),
                        SizedBox(width: 5),
                        const Text("PREMIUM DINING EXPERIENCE", style: TextStyle(fontSize: 10, letterSpacing: 1.2)),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}