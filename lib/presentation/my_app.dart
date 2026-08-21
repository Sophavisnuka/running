import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/core/theme/app_theme.dart';
import 'package:running_app/presentation/screens/home_screen/home_screen.dart';
import 'package:running_app/presentation/screens/running_screen/running_screen.dart';
import 'package:running_app/presentation/screens/setting_screen.dart';
import 'package:running_app/presentation/view_model/location_vm.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int selectedIndex = 0;
  bool startRun = false;

  final List<Widget> screens = [
    HomeScreen(),
    RunningScreen(),
    SettingsScreen(),
  ]; 

  void onNavTab(int index) {
    setState(() {
      selectedIndex = index;
      startRun = false; // Reset startRun when navigating to a different screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leadingWidth: 60,
        title: const Text(
          'Run With Me',
          style: TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on_outlined),
            color: AppTheme.primaryColor,
            onPressed: () {
              // This tap IS the user gesture the browser needs — safe to call directly.
              context.read<LocationViewModel>().loadCurrentLocation();
            },
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150', // placeholder, swap with real user photo later
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex, // default to HomeScreen
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryColor,
        currentIndex: selectedIndex,
        onTap: onNavTab,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.directions_run,
                color: Colors.white,
                size: 28,
              ),
            ),
            label: 'Run',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}