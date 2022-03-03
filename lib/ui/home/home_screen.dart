import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:my_pups/bloc/nav/app_nav_cubit.dart';
import 'package:my_pups/ui/my_profile/my_profile_screen.dart';
import 'package:my_pups/ui/my_pups/my_pups_screen.dart';

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
    const MyProfileScren(),
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

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.blueGrey.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      // body: screens[_selectedItemPosition],
      body: screens[widget.pageIndex],

      bottomNavigationBar: SnakeNavigationBar.color(
        // height: 80,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,

        ///configuration for SnakeNavigationBar
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: widget.pageIndex,

        // currentIndex: _selectedItemPosition,
        // onTap: (index) => setState(() => _selectedItemPosition = index),
        onTap: (index) => setState(() => widget.pageIndex = index),
        // onTap: _onPageChanged,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'My pups'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }

  void _onPageChanged(int page) {
    switch (page) {
      case 0:
        print(page.toString());
        // BlocProvider.of<AppCubits>(context).myPupsPage();

        setState(() {});
        break;
      case 1:
        // BlocProvider.of<AppCubits>(context).myProfilePage();

        print(page.toString());

        setState(() {});
        break;
    }
  }
}
