import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../core/app_colors.dart';
import '../widgets/glass_container.dart';
import 'home_screen.dart';
import 'menu_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MenuScreen(),
    const CartScreen(),
    const Center(child: Text("Profile under construction")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavbar(),
    );
  }

  Widget _buildBottomNavbar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Iconsax.home, 0),
            _buildNavItem(Iconsax.discover, 1),
            _buildNavItem(Iconsax.shopping_bag, 2),
            _buildNavItem(Iconsax.user, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryNeon.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primaryNeon : Colors.white54,
          size: 26,
          shadows: isSelected ? [
            const Shadow(color: AppColors.primaryNeon, blurRadius: 10),
          ] : null,
        ),
      ),
    );
  }
}
