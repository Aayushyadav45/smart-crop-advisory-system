import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/scan_leaf_screen.dart';
import 'screens/advisory_screen.dart';
import 'screens/government_schemes_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
      child: const SmartCropAdvisoryApp(),
    ),
  );
}

class SmartCropAdvisoryApp extends StatelessWidget {
  const SmartCropAdvisoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Crop Advisory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // Primary green
          primary: const Color(0xFF2E7D32),
          secondary: const Color(0xFF4CAF50), // Light green
          surface: Colors.white,
          onSurface: const Color(0xFF1F2937), // Dark text
          error: const Color(0xFFF44336), // Alert red
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E7D32),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF2E7D32),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/scan_leaf': (context) => const ScanLeafScreen(),
        '/advisory': (context) => const AdvisoryScreen(),
        '/schemes': (context) => const GovernmentSchemesScreen(),
      },
    );
  }
}
