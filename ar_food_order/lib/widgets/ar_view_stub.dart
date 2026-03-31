import 'package:flutter/material.dart';
import '../models/dish_model.dart';
import '../widgets/glass_container.dart';

class ARViewWidget extends StatelessWidget {
  final DishModel dish;
  
  const ARViewWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.view_in_ar_rounded, size: 100, color: Colors.white24),
          const SizedBox(height: 20),
          const Text(
            "AR PREVIEW UNAVAILABLE ON WEB",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          const SizedBox(height: 10),
          const Text(
            "Please run on a physical Android or iOS device\nto experience Augmented Reality.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }
}
