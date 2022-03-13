import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:my_pups/auth.dart';
import 'package:my_pups/bloc/nav/app_nav_cubit.dart';
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

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  ));
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;

  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.pinkAccent.withOpacity(0.9);
  Color unselectedColor = Colors.blueGrey.withOpacity(0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: screens[widget.pageIndex],
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 55,
        backgroundColor: Colors.black.withOpacity(0.9),
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: widget.pageIndex,
        onTap: (index) => setState(() => widget.pageIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'My pups'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
      drawer: Drawer(
        backgroundColor: Colors.pinkAccent.withOpacity(0.9),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 80),
            ListTile(
              title: AppRegularText(
                text: 'Pups Page',
                color: Colors.white,
                size: 21,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: AppRegularText(
                text: 'Auth Page',
                color: Colors.white,
                size: 21,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Auth(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onPageChanged(int page) {
    switch (page) {
      case 0:
        print(page.toString());

        setState(() {});
        break;
      case 1:
        print(page.toString());

        setState(() {});
        break;
    }
  }
}
