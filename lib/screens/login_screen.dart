import 'package:flutter/material.dart';
import 'main_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  bool _obscureText = true;
  bool _rememberMe = false;

  // NEW: Animation Controllers
  late AnimationController _rotationController;
  late AnimationController _entranceController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Setup Rotation for the dish (Continuous)
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // 2. Setup Entrance Animation for the card
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutQuart,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeIn),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1. BACKGROUND IMAGE & RED OVERLAY
          Container(
            height: screenHeight * 0.45,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_food.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.red.withOpacity(0.85),
            ),
          ),

          // 2. TOP TEXT
          Positioned(
            top: screenHeight * 0.08,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: const Column(
                children: [
                  Text(
                    "TekMeal",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "PARTNER PORTAL",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. WHITE CURVED SECTION
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.65,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        const SizedBox(height: 80),

                        // LOGIN CARD
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "Welcome back",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A237E),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              
                              const Text("Email", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                              const SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "email",
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                ),
                              ),
                              const SizedBox(height: 20),

                              const Text("Password", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                              const SizedBox(height: 10),
                              TextField(
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "••••••••",
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () => setState(() => _obscureText = !_obscureText),
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                ),
                              ),
                              
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _rememberMe, 
                                        activeColor: Colors.red,
                                        onChanged: (v) => setState(() => _rememberMe = v!)
                                      ),
                                      const Text("Remember me", style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text("Forgot Password?", style: TextStyle(color: Colors.red, fontSize: 12)),
                                  )
                                ],
                              ),

                              const SizedBox(height: 20),
                              
                              // THE SIGN IN BUTTON WITH HOVER/TAP EFFECT
                              _AnimatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MainWrapper()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text("© 2026 TekMeals. All rights reserved.", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 4. THE CENTER DISH (WITH ROTATION ANIMATION)
          Positioned(
            top: screenHeight * 0.28,
            child: RotationTransition(
              turns: _rotationController,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/centered_dish.png",
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// HELPER: Custom Button with Scale/Hover Animation
class _AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _AnimatedButton({required this.onPressed});

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
            ),
            onPressed: widget.onPressed,
            child: const Text(
              "Sign in", 
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}