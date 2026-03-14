import 'package:flutter/material.dart';
import 'order_model.dart';
import 'dart:ui'; // Required for ImageFilter

class IndividualMealsPage extends StatefulWidget {
  final Function(OrderModel) onOrderConfirmed;
  final Function(Color) onColorChange;
  const IndividualMealsPage({super.key, required this.onOrderConfirmed, required this.onColorChange});

  @override
  State<IndividualMealsPage> createState() => _IndividualMealsPageState();
}

class _IndividualMealsPageState extends State<IndividualMealsPage> with TickerProviderStateMixin {
  String selectedCuisine = "Indian";
  String selectedMealTime = "Lunch";

  final List<Map<String, String>> cuisines = [
    {"name": "Indian", "img": "assets/images/indian_cat.png"},
    {"name": "Thai", "img": "assets/images/thai_cat.png"},
    {"name": "Continental", "img": "assets/images/conti_cat.png"},
    {"name": "Italian", "img": "assets/images/italy_cat.png"},
    {"name": "Chinese", "img": "assets/images/china_cat.png"},
  ];

  // UPDATED: Dual color mapping for toggles
  final Map<String, Map<String, Color>> mealTimes = {
    "Breakfast": {
      "primary": Colors.orange,
      "bg": Color(0xFFFFF3E0), // Colors.orange.shade50
    },
    "Lunch": {
      "primary": Colors.green,
      "bg": Color(0xFFE8F5E9), // Colors.green.shade50
    },
    "Dinner": {
      "primary": Colors.purple,
      "bg": Color(0xFFF3E5F5), // Colors.purple.shade50
    },
    "Snacks": {
      "primary": Colors.blue,
      "bg": Color(0xFFE3F2FD), // Colors.blue.shade50
    },
  };

  final List<Map<String, dynamic>> allDishes = [
    {"name": "Paneer Butter Masala", "img": "assets/images/paneer.png", "cuisine": "Indian", "type": "Lunch", "isVeg": true},
    {"name": "Aloo Paratha", "img": "assets/images/paratha.png", "cuisine": "Indian", "type": "Breakfast", "isVeg": true},
    {"name": "Chicken Tikka", "img": "assets/images/chicken.png", "cuisine": "Indian", "type": "Dinner", "isVeg": false},
    {"name": "Samosa Chaat", "img": "assets/images/samosa.png", "cuisine": "Indian", "type": "Snacks", "isVeg": true},
    {"name": "Thai Omelette", "img": "assets/images/omelette.png", "cuisine": "Thai", "type": "Breakfast", "isVeg": false},
    {"name": "Pad Thai Noodles", "img": "assets/images/padthai.png", "cuisine": "Thai", "type": "Lunch", "isVeg": true},
    {"name": "Green Curry Chicken", "img": "assets/images/curry.png", "cuisine": "Thai", "type": "Dinner", "isVeg": false},
    {"name": "Thai Spring Rolls", "img": "assets/images/spring.png", "cuisine": "Thai", "type": "Snacks", "isVeg": true},
    {"name": "English Breakfast", "img": "assets/images/english.png", "cuisine": "Continental", "type": "Breakfast", "isVeg": false},
    {"name": "Grilled Chicken Steak", "img": "assets/images/grilled.png", "cuisine": "Continental", "type": "Lunch", "isVeg": false},
    {"name": "Veg Au Gratin", "img": "assets/images/gratin.png", "cuisine": "Continental", "type": "Dinner", "isVeg": true},
    {"name": "Cheese Sandwich", "img": "assets/images/sandwich.png", "cuisine": "Continental", "type": "Snacks", "isVeg": true},
    {"name": "Pancakes & Fruit", "img": "assets/images/pancakes.png", "cuisine": "Italian", "type": "Breakfast", "isVeg": true},
    {"name": "Margherita Pizza", "img": "assets/images/pizza.png", "cuisine": "Italian", "type": "Lunch", "isVeg": true},
    {"name": "Pasta Carbonara", "img": "assets/images/pasta.png", "cuisine": "Italian", "type": "Dinner", "isVeg": false},
    {"name": "Tomato Bruschetta", "img": "assets/images/bruschetta.png", "cuisine": "Italian", "type": "Snacks", "isVeg": true},
    {"name": "Breakfast Dim Sum", "img": "assets/images/dimsum.png", "cuisine": "Chinese", "type": "Breakfast", "isVeg": false},
    {"name": "Veg Hakka Noodles", "img": "assets/images/noodles.png", "cuisine": "Chinese", "type": "Lunch", "isVeg": true},
    {"name": "Kung Pao Chicken", "img": "assets/images/kungpao.png", "cuisine": "Chinese", "type": "Dinner", "isVeg": false},
    {"name": "Veg Momos", "img": "assets/images/momos.png", "cuisine": "Chinese", "type": "Snacks", "isVeg": true},
  ];

  @override
  Widget build(BuildContext context) {
    // Extract primary theme color
    final Color activeThemeColor = mealTimes[selectedMealTime]!["primary"]!;
    
    final filteredDishes = allDishes.where((dish) {
      return dish['cuisine'] == selectedCuisine && dish['type'] == selectedMealTime;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Text("Explore Cuisines", 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF103931), letterSpacing: -0.5)),
        ),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            children: cuisines.map((c) {
              bool isSelected = selectedCuisine == c['name'];
              return GestureDetector(
                onTap: () => setState(() => selectedCuisine = c['name']!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.only(right: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? activeThemeColor.withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected ? activeThemeColor.withOpacity(0.2) : Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 8)
                      )
                    ],
                    border: Border.all(color: isSelected ? activeThemeColor : Colors.transparent, width: 2)
                  ),
                  child: Column(
                    children: [
                      AnimatedScale(
                        scale: isSelected ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(c['img']!),
                          backgroundColor: Colors.grey.shade100,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(c['name']!, 
                        style: TextStyle(
                          fontSize: 13, 
                          fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                          color: isSelected ? activeThemeColor : Colors.black54
                        )),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // UPDATED: Toggle with Background and Border Colors applied to all
        Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: mealTimes.keys.map((m) {
              bool isSelected = selectedMealTime == m;
              Color mPrimary = mealTimes[m]!["primary"]!;
              Color mBg = mealTimes[m]!["bg"]!;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedMealTime = m);
                    widget.onColorChange(mPrimary);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected ? mBg : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected 
                        ? Border.all(color: mPrimary.withOpacity(0.4), width: 1.5) 
                        : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      m,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? mPrimary : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 25),

        Expanded(
          child: filteredDishes.isEmpty 
            ? Center(child: Text("No $selectedMealTime options for $selectedCuisine"))
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredDishes.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildModernFoodCard(
                    filteredDishes[index]['name'], 
                    filteredDishes[index]['img'], 
                    filteredDishes[index]['isVeg'],
                    index
                  );
                },
              ),
        ),
      ],
    );
  }

  Widget _buildModernFoodCard(String name, String img, bool isVeg, int index) {
    Color activeColor = mealTimes[selectedMealTime]!["primary"]!;
    
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        height: 240,
        margin: const EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), 
          boxShadow: [
            BoxShadow(
              color: activeColor.withOpacity(0.15), 
              blurRadius: 20, 
              offset: const Offset(0, 10)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(img, fit: BoxFit.cover),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle, 
                            color: isVeg ? Colors.green : Colors.red, 
                            size: 10
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isVeg ? "VEG" : "NON-VEG",
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name, 
                              style: const TextStyle(
                                color: Colors.white, 
                                fontWeight: FontWeight.w900, 
                                fontSize: 20,
                                letterSpacing: 0.5
                              ),
                            ),
                            Text(
                              "Chef Special • $selectedCuisine", 
                              style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)
                            ),
                          ],
                        ),
                      ),
                      
                      GestureDetector(
                        onTap: () {
                          widget.onOrderConfirmed(OrderModel(
                            orderId: "#ID${DateTime.now().millisecond}",
                            mealName: name, 
                            customization: "Standard",
                            category: selectedMealTime.toUpperCase(), 
                            time: "Next Day",
                            price: "0", 
                            status: OrderStatus.placed,
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [activeColor, activeColor.withOpacity(0.8)]),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(color: activeColor.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))
                            ]
                          ),
                          child: const Text(
                            "ADD", 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}