import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class NeonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color glowColor;
  final double? width;
  final double height;
  final bool isSecondary;

  const NeonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.glowColor = AppColors.primaryNeon,
    this.width,
    this.height = 56.0,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isSecondary 
            ? null 
            : LinearGradient(
                colors: [glowColor.withOpacity(0.8), glowColor.withOpacity(0.4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
          border: isSecondary 
            ? Border.all(color: glowColor.withOpacity(0.5), width: 1.5)
            : null,
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.25),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 10),
              ],
              Text(
                text.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
