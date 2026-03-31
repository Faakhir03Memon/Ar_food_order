import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../providers/menu_provider.dart';
import '../widgets/glass_container.dart';
import '../widgets/dish_card.dart'; // Will create this next
import 'menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(context, "Featured Dishes", () {}),
                  const SizedBox(height: 20),
                  _buildFeaturedList(context),
                  const SizedBox(height: 30),
                  _buildSectionHeader(context, "Categories", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MenuScreen()));
                  }),
                  const SizedBox(height: 20),
                  _buildCategoryList(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Text(
          "AR DINE",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text("See All", style: TextStyle(color: AppColors.primaryNeon)),
        ),
      ],
    );
  }

  Widget _buildFeaturedList(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final featuredItems = menuProvider.dishes.take(5).toList();

    if (featuredItems.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: DishCard(dish: featuredItems[index], isHorizontal: true),
          );
        },
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    final categories = ["Pizza", "Burger", "Drinks", "Sushi", "Dessert"];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              borderRadius: BorderRadius.circular(25),
              child: Center(
                child: Text(
                  categories[index],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
