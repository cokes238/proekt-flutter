import 'package:calorie_tracker/models/food_item.dart';

class DiaryEntry {
  final FoodItem food;
  final int grams; 
  final DateTime time;

  const DiaryEntry({
    required this.food,
    required this.grams,
    required this.time,
  });

  double get totalCalories => food.kcalPerGram * grams;
  double get totalProtein => food.protein * grams / 100;
  double get totalFats => food.fats * grams / 100;
  double get totalCarbs => food.carbs * grams / 100;

  String get timeString =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}