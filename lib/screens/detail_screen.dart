import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/dish_model.dart';
import '../core/app_colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/neon_button.dart';
import '../providers/cart_provider.dart';
import 'ar_view_screen.dart'; // Will create this next

class DetailScreen extends StatelessWidget {
  final DishModel dish;

  const DetailScreen({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          _buildHeroImage(context),
          _buildBackOverlay(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Hero(
      tag: 'dish_${dish.id}',
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(dish.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.4), Colors.transparent, AppColors.background],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackOverlay(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: GlassContainer(
        padding: EdgeInsets.zero,
        width: 48,
        height: 48,
        borderRadius: BorderRadius.circular(12),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(30),
            children: [
              _buildDishInfo(context),
              const SizedBox(height: 30),
              _buildDescription(context),
              const SizedBox(height: 30),
              _buildActionButtons(context),
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDishInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                dish.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ),
            Text(
              "\$${dish.price.toStringAsFixed(2)}",
              style: const TextStyle(
                  color: AppColors.primaryNeon, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
            Text(" ${dish.rating}  •  ", style: const TextStyle(fontWeight: FontWeight.bold)),
            const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 18),
            Text(" ${dish.calories} Kcal", style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("INGREDIENTS & DESC",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white38)),
        const SizedBox(height: 15),
        Text(
          dish.description,
          style: const TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Column(
      children: [
        NeonButton(
          text: "VIEW IN REALITY (AR)",
          icon: Icons.view_in_ar_rounded,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ARViewScreen(dish: dish),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: NeonButton(
                text: "ADD TO CART",
                icon: Icons.shopping_bag_outlined,
                glowColor: AppColors.secondaryNeon,
                isSecondary: true,
                onPressed: () {
                  cart.addItem(dish);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart!")),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
