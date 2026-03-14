import 'package:flutter/material.dart';
import 'order_model.dart';

class ComboMealsPage extends StatefulWidget {
  final Function(OrderModel) onOrderConfirmed;
  final Function(Color) onColorChange;

  const ComboMealsPage({
    super.key,
    required this.onOrderConfirmed,
    required this.onColorChange,
  });

  @override
  State<ComboMealsPage> createState() => _ComboMealsPageState();
}

class _ComboMealsPageState extends State<ComboMealsPage> {
  String selectedCuisine = "Indian";
  String selectedMealTime = "Lunch";
  Map<String, String> userSelections = {};

  final List<Map<String, String>> cuisines = [
    {"name": "Indian", "img": "assets/images/indian_cat.png"},
    {"name": "Thai", "img": "assets/images/thai_cat.png"},
    {"name": "Continental", "img": "assets/images/conti_cat.png"},
    {"name": "Italian", "img": "assets/images/italy_cat.png"},
    {"name": "Chinese", "img": "assets/images/china_cat.png"},
  ];

  // Updated with dual-color mapping for toggles
  final Map<String, Map<String, Color>> mealTimes = {
    "Breakfast": {
      "primary": Colors.orange,
      "bg": Colors.orange.shade50,
    },
    "Lunch": {
      "primary": Colors.green,
      "bg": Colors.green.shade50,
    },
    "Dinner": {
      "primary": Colors.purple,
      "bg": Colors.purple.shade50,
    },
    "Snacks": {
      "primary": Colors.blue,
      "bg": Colors.blue.shade50,
    },
  };

  Map<String, String> getComboData() {
    String key = "${selectedCuisine}_$selectedMealTime";
    Map<String, Map<String, String>> data = {
      "Indian_Breakfast": {"title": "Desi Nashta Combo", "items": "2 Paratha, Curd, Pickle, Tea", "img": "assets/images/ind_br.png", "isVeg": "true"},
      "Indian_Lunch": {"title": "Grand Thali", "items": "Dal, Paneer, 2 Roti, Rice, Sweet", "img": "assets/images/ind_lu.png", "isVeg": "true"},
      "Indian_Dinner": {"title": "Butter Chicken Combo", "items": "Butter Chicken, Dal, Naan, Pulao", "img": "assets/images/ind_di.png", "isVeg": "false"},
      "Indian_Snacks": {"title": "Chai Pe Charcha", "items": "Samosa, Pakora, Adrak Chai", "img": "assets/images/ind_sn.png", "isVeg": "true"},
      "Thai_Breakfast": {"title": "Phuket Sunrise", "items": "Thai Omelette, Rice, Coffee", "img": "assets/images/th_br.png", "isVeg": "false"},
      "Thai_Lunch": {"title": "Bangkok Express", "items": "Pad Thai, Spring Rolls, Iced Tea", "img": "assets/images/th_lu.png", "isVeg": "true"},
      "Thai_Dinner": {"title": "Siam Feast", "items": "Green Curry, Jasmine Rice, Satay", "img": "assets/images/th_di.png", "isVeg": "false"},
      "Thai_Snacks": {"title": "Street Side Thai", "items": "Mango Rice, Fried Wontons", "img": "assets/images/th_sn.png", "isVeg": "true"},
      "Chinese_Breakfast": {"title": "Dim Sum Morning", "items": "4 Dim Sum, Congee, Green Tea", "img": "assets/images/ch_br.png", "isVeg": "false"},
      "Chinese_Lunch": {"title": "Wok Station Combo", "items": "Manchurian, Fried Rice, Soup", "img": "assets/images/ch_lu.png", "isVeg": "true"},
      "Chinese_Dinner": {"title": "Szechuan Platter", "items": "Kung Pao, Hakka Noodles, Momos", "img": "assets/images/ch_di.png", "isVeg": "false"},
      "Chinese_Snacks": {"title": "Dragon Nibbles", "items": "Spring Rolls, Honey Potato", "img": "assets/images/ch_sn.png", "isVeg": "true"},
      "Italian_Breakfast": {"title": "Milanese Start", "items": "Frittata, Toast, Cappuccino", "img": "assets/images/it_br.png", "isVeg": "true"},
      "Italian_Lunch": {"title": "Tuscany Pasta Meal", "items": "Penne Pasta, Garlic Bread, Salad", "img": "assets/images/it_lu.png", "isVeg": "true"},
      "Italian_Dinner": {"title": "Pizza Party Combo", "items": "Large Pizza, Bruschetta, Coke", "img": "assets/images/it_di.png", "isVeg": "true"},
      "Italian_Snacks": {"title": "Venice Bites", "items": "Mini Calzone, Potato Wedges", "img": "assets/images/it_sn.png", "isVeg": "true"},
      "Continental_Breakfast": {"title": "English Platter", "items": "Eggs, Beans, Sausage, Juice", "img": "assets/images/co_br.png", "isVeg": "false"},
      "Continental_Lunch": {"title": "Healthy Grill", "items": "Grilled Steak, Mash, Veggies", "img": "assets/images/co_lu.png", "isVeg": "false"},
      "Continental_Dinner": {"title": "Euro Feast", "items": "Roast Chicken, Bread, Wine/Juice", "img": "assets/images/co_di.png", "isVeg": "false"},
      "Continental_Snacks": {"title": "Quick Club", "items": "Club Sandwich, French Fries", "img": "assets/images/co_sn.png", "isVeg": "true"},
    };
    return data[key] ?? data["Indian_Lunch"]!;
  }

  Map<String, List<String>> getCustomizationOptions() {
    String key = "${selectedCuisine}_$selectedMealTime";
    Map<String, Map<String, List<String>>> customMap = {
      "Thai_Breakfast": {"Omelette": ["Spicy", "Mild"], "Drink": ["Thai Coffee", "Hot Tea"]},
      "Thai_Lunch": {"Noodle Type": ["Flat Rice", "Glass Noodles"], "Spice": ["Medium", "Extreme"]},
      "Indian_Breakfast": {"Paratha": ["Aloo", "Paneer", "Gobi"], "Side": ["Curd", "Butter"]},
      "Italian_Lunch": {"Pasta": ["Penne", "Fusilli"], "Sauce": ["White Sauce", "Red Sauce"]},
      "Chinese_Lunch": {"Base": ["Fried Rice", "Hakka Noodles"], "Gravy": ["Manchurian", "Chili Paneer"]},
    };
    return customMap[key] ?? {"Portion": ["Standard", "Large"], "Extra": ["Sauce", "Salad"]};
  }

  void _showCustomizePopup(String title) {
    final options = getCustomizationOptions();
    final Color activeColor = mealTimes[selectedMealTime]!["primary"]!;
    userSelections.clear();
    options.forEach((key, value) => userSelections[key] = value[0]);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setPopupState) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Customization", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              const Divider(),
              ...options.entries.map((entry) => _buildOptionRow(
                    entry.key,
                    entry.value,
                    userSelections[entry.key]!,
                    activeColor,
                    (val) => setPopupState(() => userSelections[entry.key] = val),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: activeColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    widget.onOrderConfirmed(OrderModel(
                      orderId: "#CB${DateTime.now().millisecond}",
                      mealName: title,
                      customization: userSelections.values.join(", "),
                      category: selectedMealTime.toUpperCase(),
                      time: "Next Day",
                      price: "0",
                      status: OrderStatus.placed,
                    ));
                    Navigator.pop(context);
                  },
                  child: const Text("ADD TO TRAY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRow(String label, List<String> opts, String current, Color themeColor, Function(String) onSelect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: opts.map((o) {
              bool isSelected = current == o;
              return ChoiceChip(
                label: Text(o),
                selected: isSelected,
                onSelected: (_) => onSelect(o),
                selectedColor: themeColor.withOpacity(0.2),
                labelStyle: TextStyle(color: isSelected ? themeColor : Colors.black),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final combo = getComboData();
    Color activeColor = mealTimes[selectedMealTime]!["primary"]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Text("Explore Combos", 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF103931), letterSpacing: -0.5)),
        ),
        
        // Cuisine Selector
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            children: cuisines.map((c) {
              bool isSelected = selectedCuisine == c['name'];
              return GestureDetector(
                onTap: () => setState(() {
                  selectedCuisine = c['name']!;
                  userSelections.clear();
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.only(right: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? activeColor.withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected ? activeColor.withOpacity(0.2) : Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 8)
                      )
                    ],
                    border: Border.all(color: isSelected ? activeColor : Colors.transparent, width: 2)
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
                          color: isSelected ? activeColor : Colors.black54
                        )),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Dual-Color Meal Time Toggle
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
                    setState(() {
                      selectedMealTime = m;
                      userSelections.clear();
                    });
                    widget.onColorChange(mPrimary);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected ? mBg : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected 
                        ? Border.all(color: mPrimary.withOpacity(0.3), width: 1) 
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
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildModernComboCard(combo['title']!, combo['items']!, combo['img']!, combo['isVeg'] == 'true', activeColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernComboCard(String title, String items, String img, bool isVeg, Color activeColor) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
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
        height: 320, 
        margin: const EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: activeColor.withOpacity(0.2), 
              blurRadius: 25, 
              offset: const Offset(0, 15)
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  img, 
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(color: Colors.grey.shade300),
                )
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, 
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, 
                        Colors.black.withOpacity(0.1), 
                        Colors.black.withOpacity(0.95)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20, left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.stars, color: isVeg ? Colors.green : Colors.orange, size: 16),
                      const SizedBox(width: 6),
                      const Text(
                        "PREMIUM COMBO", 
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 0.5)
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, 
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 26, letterSpacing: -0.5)
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Includes: $items", 
                        maxLines: 2,
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, height: 1.4)
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => _showCustomizePopup(title),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))
                            ]
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "CUSTOMIZE & ADD", 
                            style: TextStyle(color: activeColor, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}