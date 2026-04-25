import 'package:flutter/material.dart';
import 'package:calorie_tracker/data/foods_data.dart';
import 'package:calorie_tracker/models/food_item.dart';
import 'package:calorie_tracker/models/diary_entry.dart';
import 'package:calorie_tracker/widgets/food_card.dart';
import 'package:calorie_tracker/screens/diary_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Все';
  final List<DiaryEntry> _diary = [];

  List<String> get _categories => ['Все', 'Завтрак', 'Обед', 'Ужин', 'Перекус'];

  List<FoodItem> get _filteredFoods {
    if (_selectedCategory == 'Все') return foods;
    return foods.where((f) => f.category == _selectedCategory).toList();
  }

  void _addToDiary(FoodItem food) {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: '100');
        return AlertDialog(
          title: Text('Добавить ${food.name}'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Вес порции (г)',
              suffixText: 'г',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: () {
                final grams = int.tryParse(controller.text) ?? 100;
                setState(() {
                  _diary.add(DiaryEntry(
                    food: food,
                    grams: grams,
                    time: DateTime.now(),
                  ));
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${food.name} добавлен в дневник',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
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
          // Кнопка дневника
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiaryScreen(entries: _diary),
                ),
              );
            },
            icon: const Icon(Icons.book),
            tooltip: 'Дневник',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
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
                        final food = _filteredFoods[index];
                        return FoodCard(
                          food: food,
                          onAddToDiary: () => _addToDiary(food),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _diary.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiaryScreen(entries: _diary),
                  ),
                );
              },
              icon: const Icon(Icons.book),
              label: Text('Дневник (${_diary.length})'),
              backgroundColor: Colors.teal[700],
              foregroundColor: Colors.white,
            )
          : null,
    );
  }
}