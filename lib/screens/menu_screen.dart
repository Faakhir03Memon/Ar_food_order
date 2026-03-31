import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../providers/menu_provider.dart';
import '../widgets/dish_card.dart';
import '../widgets/glass_container.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("EXPLORE MENU"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(context, menuProvider),
          const SizedBox(height: 10),
          _buildCategoryFilter(context, menuProvider),
          Expanded(
            child: _buildDishGrid(context, menuProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context, MenuProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 56,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: Colors.white70),
            const SizedBox(width: 15),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search your favorite food...",
                  hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: AppColors.primaryNeon.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune_rounded, size: 20, color: AppColors.primaryNeon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context, MenuProvider provider) {
    final categories = ["All", "Pizza", "Burger", "Drinks", "Sushi", "Dessert"];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = provider.selectedCategory == categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => provider.setCategory(categories[index]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryNeon : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDishGrid(BuildContext context, MenuProvider provider) {
    final dishes = provider.dishes;

    if (dishes.isEmpty) {
      return const Center(
        child: Text("No items found in this category.", style: TextStyle(color: Colors.white38)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        return DishCard(dish: dishes[index], isHorizontal: false);
      },
    );
  }
}
