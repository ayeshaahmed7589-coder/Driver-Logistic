import 'package:flutter/material.dart';
import 'package:logisticdriverapp/constants/colors.dart';
import 'package:logisticdriverapp/features/home/main_screens/current_screen.dart';
import 'package:logisticdriverapp/features/home/get_profile_screen.dart';
import 'package:logisticdriverapp/features/home/map_screen.dart';
import 'package:logisticdriverapp/features/home/summary_screen.dart';

class TripsBottomNavBarScreen extends StatefulWidget {
  final int initialIndex;
  const TripsBottomNavBarScreen({super.key, this.initialIndex = 0});

  @override
  State<TripsBottomNavBarScreen> createState() =>
      _TripsBottomNavBarScreenState();
}

class _TripsBottomNavBarScreenState extends State<TripsBottomNavBarScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = const [
    CurrentScreen(), 
    MapScreen(),
    SummaryScreen(),
    GetProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Expanded(child: _screens[_selectedIndex])]),
      // body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 80,
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.pureWhite,
        selectedItemColor: AppColors.electricTeal,
        unselectedItemColor: AppColors.mediumGray,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize_outlined),
            label: "Tracking",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Summary",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
