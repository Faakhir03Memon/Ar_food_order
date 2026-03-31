import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

// Services
import 'services/auth_service.dart';
import 'services/menu_service.dart';

// Providers
import 'providers/auth_provider.dart';
import 'providers/menu_provider.dart';
import 'providers/cart_provider.dart';

// Screens
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: Firebase requires google-services.json / GoogleService-Info.plist
  // try {
  //   await Firebase.initializeApp();
  // } catch (e) {
  //   print("Firebase initialization error: $e");
  // }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const ARDineApp(),
    ),
  );
}

class ARDineApp extends StatelessWidget {
  const ARDineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Dine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        primaryColor: const Color(0xFF00D2FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00D2FF),
          brightness: Brightness.dark,
          secondary: const Color(0xFF9D50BB),
        ),
        textTheme: GoogleFonts.orbitronTextTheme(
          ThemeData.dark().textTheme,
        ).copyWith(
          displayLarge: GoogleFonts.orbitron(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
