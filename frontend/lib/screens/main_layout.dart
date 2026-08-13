import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'advisory_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const AdvisoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    
    return Scaffold(
      body: _screens[appProvider.currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: appProvider.currentIndex,
          onTap: (index) {
            appProvider.setIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: appProvider.t('home') != 'home' ? appProvider.t('home') : 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history_outlined),
              activeIcon: const Icon(Icons.history),
              label: appProvider.t('history') != 'history' ? appProvider.t('history') : 'History',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.eco_outlined),
              activeIcon: const Icon(Icons.eco),
              label: appProvider.t('advisory') != 'advisory' ? appProvider.t('advisory') : 'Advisory',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: appProvider.t('profile') != 'profile' ? appProvider.t('profile') : 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

