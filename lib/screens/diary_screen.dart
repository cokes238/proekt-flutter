import 'package:flutter/material.dart';
import 'package:calorie_tracker/models/diary_entry.dart';

class DiaryScreen extends StatefulWidget {
  final List<DiaryEntry> entries;

  const DiaryScreen({super.key, required this.entries});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  double get _totalCalories {
    double total = 0;
    for (var entry in widget.entries) {
      total += entry.totalCalories;
    }
    return total;
  }

  double get _totalProtein {
    double total = 0;
    for (var entry in widget.entries) {
      total += entry.totalProtein;
    }
    return total;
  }

  double get _totalFats {
    double total = 0;
    for (var entry in widget.entries) {
      total += entry.totalFats;
    }
    return total;
  }

  double get _totalCarbs {
    double total = 0;
    for (var entry in widget.entries) {
      total += entry.totalCarbs;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дневник питания'),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
          ),
        ),
        child: widget.entries.isEmpty
            ? const Center(
                child: Text(
                  'Дневник пуст\nДобавьте продукты из каталога',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : Column(
                children: [
                  // Итоговая статистика
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(80),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Всего за день',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_totalCalories.toStringAsFixed(0)} ккал',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: _calorieColor(_totalCalories),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNutrient('Белки', _totalProtein),
                            _buildNutrient('Жиры', _totalFats),
                            _buildNutrient('Углеводы', _totalCarbs),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Список записей
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.entries.length,
                      itemBuilder: (context, index) {
                        final entry = widget.entries[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  entry.food.color.withAlpha(50),
                              child: Icon(entry.food.icon,
                                  color: entry.food.color, size: 20),
                            ),
                            title: Text(entry.food.name),
                            subtitle: Text('${entry.grams}г • ${entry.timeString}'),
                            trailing: Text(
                              '${entry.totalCalories.toStringAsFixed(0)} ккал',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _calorieColor(entry.totalCalories),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildNutrient(String label, double value) {
    return Column(
      children: [
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$label г',
          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Color _calorieColor(double calories) {
    if (calories < 1500) return Colors.green;
    if (calories < 2500) return Colors.orange;
    return Colors.red;
  }
}