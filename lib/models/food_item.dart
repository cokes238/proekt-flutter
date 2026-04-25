import 'package:flutter/material.dart';

class FoodItem {
  final String id;
  final String name;
  final int calories;     // на 100г
  final double protein;   // грамм на 100г
  final double fats;      // грамм на 100г
  final double carbs;     // грамм на 100г
  final String category;  // 'Завтрак', 'Обед', 'Ужин', 'Перекус'
  final IconData icon;
  final Color color;

  const FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.fats,
    required this.carbs,
    required this.category,
    required this.icon,
    required this.color,
  });

  double get kcalPerGram => calories / 100.0;
}