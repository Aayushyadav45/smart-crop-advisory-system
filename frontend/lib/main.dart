import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
import 'firebase_options.dart';
import 'providers/app_provider.dart';
import 'services/auth_service.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/main_layout.dart';
import 'screens/scan_leaf_screen.dart';
import 'screens/advisory_screen.dart';
import 'screens/government_schemes_screen.dart';
import 'screens/weather_screen.dart'; // ADDED
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
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
        '/auth_gate': (context) => const AuthGate(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const MainLayout(),
        '/scan_leaf': (context) => const ScanLeafScreen(),
        '/advisory': (context) => const AdvisoryScreen(),
        '/schemes': (context) => const GovernmentSchemesScreen(),
        '/weather': (context) => const WeatherScreen(), // ADDED
      },
    );
  }
}
 
/// Decides whether to show MainLayout (with bottom nav) or LoginScreen based
/// on current Firebase auth state. Reached after language selection on Splash.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const MainLayout(); // already logged in — includes footer nav
        }
        return const LoginScreen(); // not logged in
      },
    );
  }
}