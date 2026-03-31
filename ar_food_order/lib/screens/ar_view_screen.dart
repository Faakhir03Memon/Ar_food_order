import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import '../models/dish_model.dart';
import '../core/app_colors.dart';
import '../widgets/glass_container.dart';
import '../widgets/ar_view_adapter.dart'; // Use the adapter instead of direct plugin

class ARViewScreen extends StatefulWidget {
  final DishModel dish;

  const ARViewScreen({super.key, required this.dish});

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  String currentStatus = kIsWeb ? "AR is not supported on Web. Use a mobile device." : "Scan your table slowly...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ARViewWidget(
            dish: widget.dish, 
            onStatusChange: (status) => setState(() => currentStatus = status),
          ),
          _buildOverlay(context),
          _buildStatusIndicator(),
          _buildBackOverlay(context),
        ],
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.dish.name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionIcon(Icons.refresh_rounded, "Reset", () {
                  // Reset logic handled via re-navigation if needed or state reset
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (_) => ARViewScreen(dish: widget.dish)),
                  );
                }),
                _buildActionIcon(Icons.camera_rounded, "Capture", () {}),
                _buildActionIcon(Icons.close_rounded, "Exit", () => Navigator.pop(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryNeon.withOpacity(0.2),
            child: Icon(icon, color: AppColors.primaryNeon),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Center(
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          borderRadius: BorderRadius.circular(30),
          child: Text(
            currentStatus,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildBackOverlay(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
