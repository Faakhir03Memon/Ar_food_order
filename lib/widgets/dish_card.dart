import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/dish_model.dart';
import '../core/app_colors.dart';
import 'glass_container.dart';
import '../screens/detail_screen.dart'; // Will create this soon

class DishCard extends StatelessWidget {
  final DishModel dish;
  final bool isHorizontal;

  const DishCard({
    super.key,
    required this.dish,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(dish: dish),
          ),
        );
      },
      child: Hero(
        tag: 'dish_${dish.id}',
        child: GlassContainer(
          width: isHorizontal ? 200 : double.infinity,
          height: isHorizontal ? 280 : 160,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: isHorizontal ? 3 : 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(dish.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${dish.price.toStringAsFixed(2)}",
                          style: const TextStyle(color: AppColors.primaryNeon, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                            Text(
                              " ${dish.rating}",
                              style: const TextStyle(fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
