import 'package:flutter/material.dart';
import 'package:calorie_tracker/models/food_item.dart';

class FoodDetailScreen extends StatelessWidget {
  final FoodItem food;
  final VoidCallback? onAddToDiary; // callback для добавления в дневник

  const FoodDetailScreen({
    super.key,
    required this.food,
    this.onAddToDiary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.name),
        backgroundColor: food.color,
        foregroundColor: Colors.white,
        actions: [
          // Кнопка добавления в дневник
          IconButton(
            onPressed: () {
              if (onAddToDiary != null) {
                onAddToDiary!();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Нажмите "+" на главном экране чтобы добавить ${food.name}',
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.add_shopping_cart),
            tooltip: 'Добавить в дневник',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Иконка
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: food.color.withAlpha(40),
                shape: BoxShape.circle,
              ),
              child: Icon(food.icon, size: 48, color: food.color),
            ),
            const SizedBox(height: 12),
            Text(
              food.category,
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Карточка калорий
            _buildNutrientCard('Калории', '${food.calories}', 'ккал',
                food.color),
            const SizedBox(height: 12),

            // КБЖУ
            Row(
              children: [
                Expanded(
                  child: _buildNutrientCard(
                      'Белки', '${food.protein}', 'г', Colors.blue),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildNutrientCard(
                      'Жиры', '${food.fats}', 'г', Colors.orange),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildNutrientCard(
                      'Углеводы', '${food.carbs}', 'г', Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Визуализация пропорций
            const Text(
              'Соотношение КБЖУ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 28,
                child: Row(
                  children: [
                    Flexible(
                      flex: (food.protein * 4).round(),
                      child: Container(color: Colors.blue),
                    ),
                    Flexible(
                      flex: (food.fats * 9).round(),
                      child: Container(color: Colors.orange),
                    ),
                    Flexible(
                      flex: (food.carbs * 4).round(),
                      child: Container(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        width: 10,
                        height: 10,
                        color: Colors.blue,
                        margin: const EdgeInsets.only(right: 4)),
                    const Text('Белки', style: TextStyle(fontSize: 11)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 10,
                        height: 10,
                        color: Colors.orange,
                        margin: const EdgeInsets.only(right: 4)),
                    const Text('Жиры', style: TextStyle(fontSize: 11)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 10,
                        height: 10,
                        color: Colors.green,
                        margin: const EdgeInsets.only(right: 4)),
                    const Text('Углеводы', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Кнопка добавления в дневник (дублируем снизу)
            if (onAddToDiary != null)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    onAddToDiary!();
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Добавить в дневник'),
                  style: FilledButton.styleFrom(
                    backgroundColor: food.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientCard(
      String label, String value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: TextStyle(fontSize: 12, color: color.withAlpha(180)),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color.withAlpha(180),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}