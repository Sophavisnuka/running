import 'package:flutter/material.dart';
import 'package:running_app/ui/screens/activities_screen.dart';
import 'package:running_app/ui/screens/home_screen.dart';
import 'package:running_app/ui/screens/map_screen.dart';
import 'package:running_app/ui/screens/setting_screen.dart';

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
    ActivitiesScreen(),
    SettingScreen(),
  ]; 

  void onNavTab(int index) {
    setState(() {
      selectedIndex = index;
      startRun = false; // Reset startRun when navigating to a different screen
    });
  }

  void _toggleStartRun() {
    setState(() {
      startRun = !startRun;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      floatingActionButton: selectedIndex == 0
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (startRun)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FloatingActionButton.extended(
                    heroTag: 'startRun',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const MapScreen()),
                      );
                    },
                    backgroundColor: Color.fromARGB(255, 243, 93, 33),
                    icon: const Icon(Icons.directions_run, color: Colors.white),
                    label: const Text('Start Run', style: TextStyle(color: Colors.white)),
                  ),
                ),
              FloatingActionButton(
                heroTag: 'mainFab',
                onPressed: _toggleStartRun,
                backgroundColor: Color.fromARGB(255, 243, 93, 33),
                child: Icon(
                  startRun ? Icons.close : Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          )
        : null,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60,
        title: const Text(
          'Stride',
          style: TextStyle(
            color: Color.fromARGB(255, 243, 93, 33),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
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
        selectedItemColor: const Color.fromARGB(255, 243, 93, 33),
        currentIndex: selectedIndex,
        onTap: onNavTab,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Activities',
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