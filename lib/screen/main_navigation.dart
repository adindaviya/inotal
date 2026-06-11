import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'dashboard_statistic.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final pages = const [
    Home(),
    DashboardStatistic(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.orange,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Talent",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Statistik",
          ),
        ],
      ),
    );
  }
}