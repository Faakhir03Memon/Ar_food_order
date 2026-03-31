import 'package:flutter/material.dart';

class AppColors {
  // Primary Blacks
  static const Color background = Color(0xFF050505);
  static const Color surface = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFF1E1E1E);

  // Neon Accents
  static const Color primaryNeon = Color(0xFF00D2FF);  // Electric Blue
  static const Color secondaryNeon = Color(0xFF9D50BB); // Deep Purple
  static const Color accentNeon = Color(0xFF3A1C71);    // Midnight Purple

  // Semantic
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFFF5252);
  static const Color textMain = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Colors.white38;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryNeon, secondaryNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Colors.white12, Colors.white10],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
