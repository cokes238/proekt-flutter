import 'package:flutter/material.dart';
import 'package:calorie_tracker/models/food_item.dart';
import 'package:calorie_tracker/screens/food_detail_screen.dart';

class FoodCard extends StatelessWidget {
  final FoodItem food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetailScreen(food: food),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Иконка
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: food.color.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(food.icon, color: food.color, size: 26),
              ),
              const SizedBox(width: 12),

              // Название и категория
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      food.category,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Калории
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _calorieColor(food.calories).withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${food.calories} ккал',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _calorieColor(food.calories),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Color _calorieColor(int calories) {
    if (calories < 100) return Colors.green;
    if (calories < 200) return Colors.orange;
    return Colors.red;
  }
}