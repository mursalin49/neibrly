import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naibrly/provider/views/home/home_screen.dart';
import 'package:naibrly/provider/views/orders/orders_screen.dart';
import 'package:naibrly/provider/screens/notifications_screen.dart';
import 'package:naibrly/provider/screens/profile/ProfilePage.dart';
import 'package:naibrly/provider/screens/splash_screen.dart';
import 'package:naibrly/provider/widgets/colors.dart';
import 'package:naibrly/provider/widgets/home/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Naibrly",
      theme: ThemeData(
        scaffoldBackgroundColor: KoreColors.background,
        primaryColor: KoreColors.primary,
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      builder: (context, child) => SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: child ?? const SizedBox.shrink(),
      ),
      home: const SplashScreen(),
    );
  }
}

class NairblyApp extends StatefulWidget {
  const NairblyApp({super.key});

  @override
  State<NairblyApp> createState() => _NairblyAppState();
}

class _NairblyAppState extends State<NairblyApp> {
  int _currentBottomNavIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const NotificationsScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Naibrly",
      theme: ThemeData(
        scaffoldBackgroundColor: KoreColors.background,
        primaryColor: KoreColors.primary,
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      builder: (context, child) => SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: child ?? const SizedBox.shrink(),
      ),
      home: Scaffold(
        body: _screens[_currentBottomNavIndex],
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentBottomNavIndex,
          onTap: (index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
          },
        ),
      ),
    );
  }
}
