import 'package:flutter/material.dart';
import 'package:logisticdriverapp/features/home/current_screen.dart';
import 'package:logisticdriverapp/features/home/get_profile_screen.dart';

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
    CurrentScreen(), // your Trips screen
    Center(child: Text("Tracking")),
    Center(child: Text("Summary Screen")),
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
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFF1A56DB),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
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
