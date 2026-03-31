import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF050505),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Lottie animation
            // Lottie.asset('assets/animations/splash_logo.json', width: 250),
            const Icon(Icons.restaurant_menu_rounded, size: 100, color: Color(0xFF00D2FF)),
            const SizedBox(height: 30),
            Text(
              "AR DINE",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                letterSpacing: 8,
                shadows: [
                  const Shadow(
                    color: Color(0xFF00D2FF),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "AUGMENTED REALITY FOOD EXPERIENCE",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white38,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
