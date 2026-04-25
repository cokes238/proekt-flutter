import 'package:flutter/material.dart';
import 'package:calorie_tracker/data/foods_data.dart';
import 'package:calorie_tracker/widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Все';

  List<String> get _categories => ['Все', 'Завтрак', 'Обед', 'Ужин', 'Перекус'];

  List<FoodItem> get _filteredFoods {
    if (_selectedCategory == 'Все') return foods;
    return foods.where((f) => f.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🔥'),
            SizedBox(width: 8),
            Text('Calorie Tracker'),
          ],
        ),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${foods.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
          ),
        ),
        child: Column(
          children: [
            // Фильтр категорий
            Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      selectedColor: Colors.teal[600],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Счётчик отфильтрованных
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                children: [
                  Text(
                    'Продуктов: ${_filteredFoods.length}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Список продуктов
            Expanded(
              child: _filteredFoods.isEmpty
                  ? const Center(
                      child: Text('Нет продуктов в этой категории',
                          style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: _filteredFoods.length,
                      itemBuilder: (context, index) {
                        return FoodCard(food: _filteredFoods[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}