import 'package:flutter/material.dart';
import 'package:todo_and_note/view/screens/dashboard_screen.dart';
import 'package:todo_and_note/view/screens/home_screen.dart';
import 'package:todo_and_note/view/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const DashboardScreen(),
    const ProfileScreen()
  ];

  int _selectedIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: screenWidth > 480
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                NavigationRail(
                  backgroundColor: const Color(0xFFFDE49E),
                  indicatorColor: const Color(0xFFFEB941),
                  labelType: NavigationRailLabelType.all,
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onTapped,
                ),
                Expanded(
                  child: screens[_selectedIndex],
                )
              ],
            )
          : IndexedStack(
              index: _selectedIndex,
              children: screens,
            ),
      bottomNavigationBar: screenWidth <= 480
          ? NavigationBar(
              backgroundColor: const Color(0xFFFDE49E),
              indicatorColor: const Color(0xFFFEB941),
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: Icon(Icons.dashboard),
                  label: "Dashboard",
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onTapped,
            )
          : null,
    );
  }

  Widget _getSelectedWidget(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const DashboardScreen();
      case 2:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }
}
