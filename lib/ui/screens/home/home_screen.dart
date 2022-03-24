import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/screens/my_pups/my_pups_screen.dart';
import 'package:my_pups/ui/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  int pageIndex;
  HomeScreen({Key? key, required this.pageIndex})
      : super(
          key: key,
        );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    const MyPupsScreen(),
    const ProfileScreen(),
  ];

  Color selectedColor = Colors.pinkAccent.withOpacity(0.9);
  Color unselectedColor = Colors.blueGrey.withOpacity(0.8);

  int _currentIndex = 0;
  final _selectedColor = Color.fromARGB(255, 70, 90, 121);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: (SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
                icon: const Icon(Icons.pets),
                title: const Text("My Pups"),
                selectedColor: _selectedColor),

            /// My Profile
            SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text("Profile"),
                selectedColor: _selectedColor),
          ],
        )),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 80),
            ListTile(
              title: const AppRegularText(
                text: 'Pups Page',
                color: Colors.white,
                size: 21,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const AppRegularText(
                text: 'Auth Page',
                color: Colors.white,
                size: 21,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/auth',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
