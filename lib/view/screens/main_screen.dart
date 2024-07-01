import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:todo_and_note/view/screens/dashboard_screen.dart';
import 'package:todo_and_note/view/screens/home_screen.dart';
import 'package:todo_and_note/view/screens/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  final Function(int) changeLanguageCallback;
  const MainScreen({super.key, required this.changeLanguageCallback});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isConnectedToInternet = false;

  StreamSubscription? _internetConnectionStreamSubscription;
  late ProfileScreen profileScreen;

  @override
  void initState() {
    super.initState();

    profileScreen =
        ProfileScreen(changeLanguageCallback: widget.changeLanguageCallback);

    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          isConnectedToInternet
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Center(
                      child: Text("Back Online"),
                    ),
                  ),
                )
              : null;
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.black,
              content: Center(
                child: Text("No Connection"),
              ),
            ),
          );
          break;
        default:
          setState(() {
            isConnectedToInternet = false;
          });
      }
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  int _selectedIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomeScreen(),
      const DashboardScreen(),
      profileScreen
    ];
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
                  destinations: <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: const Icon(Icons.home),
                      label: Text(AppLocalizations.of(context)!.home),
                    ),
                     NavigationRailDestination(
                      icon: const Icon(Icons.dashboard),
                      label: Text(AppLocalizations.of(context)!.dashboard),
                    ),
                     NavigationRailDestination(
                      icon: const Icon(Icons.person),
                      label: Text(AppLocalizations.of(context)!.profile),
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
              destinations: <NavigationDestination>[
                NavigationDestination(
                  icon: const Icon(
                    Icons.home,
                  ),
                  label: AppLocalizations.of(context)!.home,
                ),
                 NavigationDestination(
                  icon: const Icon(Icons.dashboard),
                  label: AppLocalizations.of(context)!.dashboard,
                ),
                 NavigationDestination(
                  icon: const Icon(Icons.person),
                  label: AppLocalizations.of(context)!.profile,
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onTapped,
            )
          : null,
    );
  }
}
